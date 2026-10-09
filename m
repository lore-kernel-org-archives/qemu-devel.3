Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D33CA9EBE
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 21:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFIcL-0007DN-8n; Fri, 09 Oct 2026 17:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFIcE-0007BE-72
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 17:58:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFIcC-0006Nb-GD
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 17:58:57 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KhbaX3274742
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 21:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S9ZePIPCHQPP0Hlpo5PmoQBgXZ9ndzr7/twaEce3jBk=; b=mFlm4scXDkwCi18G
 Sn3I6DcNx0zzqfY4WFAO0RtmmTlclThJ7moLJZ18h3ebUbnszUuRQVOjpo5yoTLr
 wzoOSKis1d6a1GlrUTjaR4Vv5OBjzp95tiZi3Zs0GXQl5b4ycV9b2vI0pPTdCSmO
 5DGuL/ZqoFhsgmjLOUIXru99W//B1iyb8lD0nnXNtH/j4pUeQ82Pub6uuVXAWiOy
 3kyPY+uUI+nCfP9k9Ww7CYrecAhCwE3LTsg6YAeAZzyJJvQI/VJD6+Zivfm/BNvf
 Ee8Q4bDzqkSMomiXFnMXc+XWTvvYwDcNX1NfJaQer9OZ9kU/R6z7enpcY9zevqpQ
 dMsgJw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t7gvqq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 21:58:55 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-34ef0362d95so350526eec.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 14:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791583134; x=1792187934; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S9ZePIPCHQPP0Hlpo5PmoQBgXZ9ndzr7/twaEce3jBk=;
 b=VfPila43Zr0WDjuVrxSlkvC8o9wLQ0Riy42nG8ohuG8HvIqYXjRLZ3EIjivPwF8GYY
 lXH9MqfiRI57BDcvblQ2b8TNizITuCPOY+b8UnyUL5oEzs1pWUTy7huaetMvuRDT495X
 56xLrwjl5c2rk3GLDliVEh9AyDH/96X6sOHU0efuht6qHsJO3fGRZXe+QvKNmkjHPep9
 vaOSqSf5PJiL0ZFc0DwpGUjcsoWQ6rMKU8LjxBWg9ct34KDazztTzqcmcxcqMa8Q2caQ
 fDLt4lyMx+kOBruC2JLBnZi/NfNxRp3lCDBZcbJrNOM+RgYI/PGF4GgjOqNjciLWHdhH
 YPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791583134; x=1792187934;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S9ZePIPCHQPP0Hlpo5PmoQBgXZ9ndzr7/twaEce3jBk=;
 b=DBfni0nPWnNV/EmWfqa7GagaIKaiW0/jsuYQTRHclp5+c8RO/Me1qf9EBNOMIMC1ZZ
 ym4lMkKKEaHsLKHd0612UOXASeeYCTFuVUW4tBDBsoXZ9qdEdu7GsHBWizb9Sm4095m4
 tJtFDizOFR4KICfSP2eu09t9xgmMDWHBVQ1tTn+SJrRhYs91nnmZQDf/XU7HvkkkB1jM
 i5rOWdzpL3Ho1ZvuyE+joyXJXVuyKVjz8j1vDGm84tU/+LkEPNRvy+o0tA8KI6fOfbmo
 Z3eYycAFhWwguAz8IGS96vXH+J1nrEVhnBFXWTaLxRuMkdLlVizgzX0lQVH920N/TEz4
 ipow==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmnRCXcCROOAaZbsNuxydd+Y39pnnCwOjDIB86af068b0XuepD+9iOmpa2vK7FQlWrJpypbI8f+s2/@nongnu.org
X-Gm-Message-State: AFq9FYKje+h+cgfm4fK6rkSoaSnVrJxXOsOnoCEHIalj8TRhjRDtHPle
 VoSYiJwYTTZBPd6TIBbsBtD77zoURgV4UziiLZ96tb/Gj4nnKacThTuBbwYGlTPU01YGhlEH+Yg
 oJI98bhSs4Tg6sn2igO1ugo9NmZw79y4MgyKqBD23mxRohsnISXLJnzgQQg==
X-Gm-Gg: AYBFou3VsOH4du+H5Ke3LDWjzABw5cBIAOzTA17nQcCxgFYJAVVHziX0nf6DnZo1Uus
 gP0idHa8hihcmQtF9UhwL5UojO2j81S5xOgBM4K+xuVxea/xo4n+eGuNZFSeJWr5oJLSKMO9Upd
 jfrtbAbGD17wTP5vuQjV/44n/bUK7uKevoMRkllij79a0hHB8vEKfAS8o5QP5/mBw1Qxt+KjK1H
 NfqeSBOGC8YF37MrOYrrqJnnConLXdzapIn6xGN58RV9cBYJN0uMk8WwZ91cXjozyPDVwumll69
 WuicFhDY5ItBbxUCUM4Je7L2Cf+IOcMCDxulVOxBjEcNjYwSTLdKK9iniUkLQ+AHXMcIR8+6ZY/
 5QGcMT3/L9h9Tk3ReWqAEuDvUaJqSCCCv0V1zMFxl94TY60dZbu5/yUYMFy+DrlNXn5ygFg==
X-Received: by 2002:a05:7022:5f14:b0:143:2973:3240 with SMTP id
 a92af1059eb24-16a61d5bd77mr3297452c88.29.1791583133768; 
 Fri, 09 Oct 2026 14:58:53 -0700 (PDT)
X-Received: by 2002:a05:7022:5f14:b0:143:2973:3240 with SMTP id
 a92af1059eb24-16a61d5bd77mr3297430c88.29.1791583133137; 
 Fri, 09 Oct 2026 14:58:53 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becefdsm8255218c88.7.2026.10.09.14.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 14:58:52 -0700 (PDT)
Message-ID: <9ee6fad5-4117-42f2-95da-818d5b4e0aa9@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 14:58:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] qom: pass TargetInfo to the is_available callback
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Alexander Bulekov <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <3631c54a-5ad7-4037-a21b-37c3c61d712d@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3631c54a-5ad7-4037-a21b-37c3c61d712d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=W8atxhWk c=1 sm=1 tr=0 ts=6ac9639f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=fikX_qdtNkxtpiNuNakA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: pbqQnK5FSIquhnOlizyVxBT4NwGsakaE
X-Proofpoint-ORIG-GUID: pbqQnK5FSIquhnOlizyVxBT4NwGsakaE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA4NyBTYWx0ZWRfXxL8R912UgbDb
 oP8emH3IsnkbIBY9FQcdCz6Cjt05O2dyqD4Eu0ghSsUxKV8IuGDQ0ZryGfEhksqNIE+3pb5PE6T
 xXBjeMvhhlmWUwkO2dts0F7THKqikLg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA4NyBTYWx0ZWRfXwVQtzqs+eZp4
 X+c1n7igTxHN5dfqsHkELuMmnOcmab8CSgiS//jxiKcbgwWNihxRgeasjWT2DdOTXpQ9mC6Gm/+
 Y3ghIm/UqkVa7GPQIAA9hu4Erc1LdnV9xVQSPxtAdaPCW6DJUIiogksiKqGHHYAQZzjAWdsa8om
 PRBs7iC+0DUW479uF/Cu2/R5jxEA7m0GRa7oZ95/f2Ci1lj59FzpBrYj7GrFEEdkKh4XlR9jDeb
 yacZWwKRzxj0YJmcoXjWgOk68+F75ykxxEvaZ5evcmStB0UQmGT85pkOwpVDAVjc33vrPKyOCQN
 ZW3gfojyUP9pULH6yYP0Q4xgvf8ocbEsc5tbpMfwnSeNAJqkkpTn6NKf5rz1dyCRjbQEm6NwwLT
 3j6RsPDrbRxwbEyOkE5djMjHMaSgfLqxFlzV8w7ws/Zp/btXwc4YCf8iP2j0r7eA91m49y4oPv6
 c+Dttm8IFDEqWaOPJVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/7/2026 1:46 PM, Pierrick Bouvier wrote:
> 
> I'll pull the first three patches.
>

Now merged upstream (40ba85501c0b6ac2a7319d3804dab072edf67564)

Thanks,
Pierrick

