Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7164AFEFB51
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4Qx-0004Xb-Mb; Fri, 27 Feb 2026 15:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vw4Qp-0004Wm-TP
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:27:30 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vw4Qo-0005Cq-3t
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:27:27 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RH0Rvu065508
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Td16kqcg+TPRxFR+xlLquf80+8PBpCDG1LsZZ6CsW9U=; b=hZ27k1wejrXoPJbX
 yrhM+BD6SgIRL0dM2QRanRG/B5Y8dtVaYDSsL4zaHTfTpmwVneToJ9Q8UDX5Iykg
 t2qO5MsGQwyIaNZjcENl1JeRPc72F7xqT9Xlw6oh5piwJ9Rh3EnDAkcu7JNDHgub
 p2RzVPgH2vj6g5AaW35hNEyEHgdfSmTCbzR7xkwZjrnhBT2fooP9/f2eGBMvglU5
 Sq4P/H2SA/4ERegETheNQSSl3pK12p1amP77GVInHr8pv1XoPLdKLGi3iCgrcs2l
 Q/qahLfdsPxQNzxenCO2+fhTTdcc9SeDQkCZulGLZZWCIxIJ5Sb1L8pC0ewEubnc
 oULEbw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cka2xhq5q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:27:24 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2bde0d4fb18so1443531eec.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224043; x=1772828843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Td16kqcg+TPRxFR+xlLquf80+8PBpCDG1LsZZ6CsW9U=;
 b=cDezr8Ba+X7jrp2IykCkez1By3z2Z11lqvVWdH5PsuNUqpmDnw/+yRMU84ZXFCn9H0
 VXapGYgROtS3hIDeNpM/2wxZlqkfwFaPr+7Qw7uaJRCcooYD8A7hKXARyJ9E+nt7gg2c
 wgVYETHkyjntr0Mlb7vjRXe7h4fhUvNl7HNCwJii43W+KB2klMay+veYVkOaMIP8TuoF
 VYiy2YEV7Sk5abUeLyU3N65qW8Gd7WX1G4mVKJq9uiWzzrd+TyQmsu50kEu68uSwEIEP
 QGV6T/B9LnEZ5e8Spsi+7z45nYsWt+o7daSmX4cGXoYEU6XqLepsbSnNDrpCsbWgepNB
 HcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224043; x=1772828843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Td16kqcg+TPRxFR+xlLquf80+8PBpCDG1LsZZ6CsW9U=;
 b=X514amLzTE0nHaq3Ljg+JAsb5Hc3nOWvNBg/FvIZUWlihwGGt+WYtT1AnPjodr+X26
 nbvgm6HP83IKJg0YN60MHLUgD6JyhYDOtd08smjKmOI2sBJfHscouU6OXK8tjyY0cqdK
 uk1e1tHH7FigX/ikNXpM8ps51m60Y6Knx8mijbhC3Fme8rBsM/LNykUgDC7hUDQrtsIf
 NFiUZShm/SB5TFLOCDQOux5F3//d8UUAGKXCiwE+6BT+jKXgml7Us3iM8Xq/vQRWtUa5
 k1HOW9KOfROiJm7k1dUl3kvkSZdjqioh0ppCmBhE+BoaijYXyEgeZ8wY1n+pLeJDYEti
 BDPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMQ/ktHmisA8X55gsUPixW3EBTaXAIUGv7b4/bvOVqzrOi0/6n88rNgip7LoDrNPy7AqeNP02/b7yM@nongnu.org
X-Gm-Message-State: AOJu0YyKEsTYsSQ5FT0tQpgkaPcZOVOEoSGQ7JDqOtcdrdqSgdCqGwoM
 lo/TpcWs+SikWRjI5MYXoTVgRDNabV8ytNB2VvGA5+klDkPAP+0xiQpDB2ii+XCuY6A02MiT0KO
 MThKutgI/JkFmNEEDCI+OIO7TpRz+/dCOL5jdnQ0P/SIkYy8Wr2AhsQwYew==
X-Gm-Gg: ATEYQzxIiWOFDuTbj2Q3MUJRQ1AgIBVX24o08bCCJNJDzrzov3U/rF1LIky7U9mHI3O
 h4ZqIW0yncAla7XTinZ4qyinFW8uL7olFxEXnkmzzhnzY+b6JojihF0/T193fZM8YyFtwBKn8bS
 M+48pqCnjFICBU7W6waW0BR6IqwxXJ60D973w1A0ZCn0n7pHjVLU5mXgCpkH1TKPHREHhbzCx8P
 J1ZG0yZ/BjRb/rqfnv2FiZ+idDkFgJ5JGuZQlOJeDWUn733+Wf3Sghzfh1A0nqV2bTpzLmMssOs
 Z1IFQe/mIPBwzIh1mlO3NGZbEVTX9U/mf1yVFOlDs6YJZGN37K69ViR3ezIuAHFNNhwGmgvAkkd
 HmCr8MAXte6VoNAtokX8b1EhayjiEUOA+jIN1vcWh+Ut7JsUOpSEKMxw+WNmyTi2blkRTokRQzn
 KCyA==
X-Received: by 2002:a05:7022:79f:b0:119:e569:f60d with SMTP id
 a92af1059eb24-1278fb606bdmr2073582c88.6.1772224043390; 
 Fri, 27 Feb 2026 12:27:23 -0800 (PST)
X-Received: by 2002:a05:7022:79f:b0:119:e569:f60d with SMTP id
 a92af1059eb24-1278fb606bdmr2073559c88.6.1772224042604; 
 Fri, 27 Feb 2026 12:27:22 -0800 (PST)
Received: from [10.110.80.16] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789a32863sm5307490c88.10.2026.02.27.12.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 12:27:21 -0800 (PST)
Message-ID: <dcfa638b-fbcd-479d-aa1d-9b193b530d1d@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 12:27:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/22] hw/i3c: Add bus support
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "komlodi@google.com" <komlodi@google.com>,
 Patrick Venture <venture@google.com>, Titus Rwantare <titusr@google.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
 <20260225021158.1586584-4-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
In-Reply-To: <20260225021158.1586584-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BOC+bVQG c=1 sm=1 tr=0 ts=69a1fe2c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=5-m66uigXNRcoxOG-vkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: 847Cr46LOKPHSIPeZPYJd8q8IJg0i_-6
X-Proofpoint-ORIG-GUID: 847Cr46LOKPHSIPeZPYJd8q8IJg0i_-6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE3OSBTYWx0ZWRfXxr0vjzPIb2sm
 z64dx01kPuOo7UI15MFuFVsSUM/8eyagtkQ2j81qyzYppqzf7Vi7EU0XLCXMsESHynmGbOuXa7z
 yCroPpj4bg2kfcgFzgXkCwmNmGtUOwhUaSfQW1vpa0O2Lm45khazuMjrU9EmL3FfvfDp4F5Keh4
 AsNFaziDbgdJjyS37lqhxnEnVZkkLb6qh+22kgQFQlsSV5TIHAomfNPietGjo/KO5lvqNp1v+bq
 5PxxsqYVrlpY+dVZxc7p1ajSOsYLeKexCbXwnAYE+KYJvhzv6gj0jCMNA8GzHb1QCCVtvMfOpDi
 HL3W9VrVYGE4CasgE2W/Go6nnoYm/9QBconIyg2Rqo76yNk+Wwwcrqptc63J2nlmFL9dFrEbWEB
 pbac/+kFsDoHmR46ZTAtUCuDUWUW2dlrcULl9CQ3/czi4abEMN8NXBx+S5T9do0fk+vg/wZOZ7R
 Myx/f9h1eynLXz6BLww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270179
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/24/2026 6:12 PM, Jamin Lin wrote:
> Adds an I3C bus and a target class.
> The bus supports:
> - I3C data transmission and reception
> - CCCs (including ENTDAA)
> - IBIs
> - legacy I2C transactions

Reviewed-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>



Thanks
Jithu

