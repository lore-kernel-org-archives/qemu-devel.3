Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32D7606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GS6kUiFg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jD6sItqf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLRxJ-0005wi-Qr; Mon, 26 Oct 2026 17:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLRxG-0005wO-5B
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:10:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLRxD-0005WK-74
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:10:04 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QIoF5q986050
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 21:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gX9yG9jIqQwkWiUDPbtQunYMKSLpCSW+8K0BoNG2hzg=; b=GS6kUiFg2aN+9zvg
 8g1l+kR4i5KprvFv64T9olQwVj1w7PzBmu/4qwhNluYsHddBvgmtl/0SmGYUWBWG
 jA17W+JBMGsf0hWLLxYN3KaS3tUQqwEfv8ekDUOfAtBDp//DEgoXRgERmu1z6w8V
 a37rdPc7500/QaSlw608SmmSwjbHv8cuTndKmXgbvUlauJz6TjeCISaFhvkxRZN3
 SdObPYt+S5Wipylbc1RzWm/MbquANMQtQlR78yNfoVk0kMeN0+zsUphF49TE1DRo
 upkMlDf5DaI/l33OJV9qYeWMw/tcn8zEe4k+rsZ4PNGbChvWfb+MrsORqRD6CdID
 FgbvIA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj53q2ddd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 21:10:01 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35cbea41088so5503136eec.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 14:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793049001; x=1793653801; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gX9yG9jIqQwkWiUDPbtQunYMKSLpCSW+8K0BoNG2hzg=;
 b=jD6sItqf9pQMJ+rsTAHPYi+CvxiJl8lQG5shI5dXIZ3ayfuF572Rhl2dVWYv9ME5n7
 G9du8Tk8a2PHd3tNJS07VeEvnFvp41gMuFLraGv6jlYkJUGB2A/9T97+pEBummqm0ZSe
 Qls7RM0Miwgx5SojIQNhfnazddW7pqey3nYmCnCj/n86uEqcY1DEleEywpCfSuxnmXe+
 8dlX8UFbDYBbtagp6YUdXQo7cdHmtmFfy2GBAJUggQD0kEMtfUSPHc1t1h/NIqvZ5lKs
 Xolg8A8dQAISM64saZIvF2cKYG/Sz+J+WEs/i2oaHc7HboNYw36m33NOYR9hBmh/3YOo
 Y4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793049001; x=1793653801;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gX9yG9jIqQwkWiUDPbtQunYMKSLpCSW+8K0BoNG2hzg=;
 b=kaE05WakqlcaDrAdR846b0GPXezeuWoVw9n6q00F7sa7dUuen6Esw6Cacen2xW7vHu
 g1V+qFpY9zJo4ILqU0Cng51uDxFTlTdq2Et+Y1MJZMiAd2ySJKuyfqZylrfEgLXDkbfN
 Ed8SyReAmYmXnRo1dIFojsSSjXEzJDvlv8TJ8CW1yOXvtuk8A/CNum+L3at5L4lvL3OZ
 OwAsvwM2eg3+g8ipm9ZyXCtpp8gMolpMgNFnhMQ1VgvxT88ru+FUUp36tqgOuURcooP4
 G/m5q6cm7EwueEzmxhRrLSDHGu+ii4aQgCaQq/XS5+qdRtJ1xPUTBQaZsFdJkG7KLOd1
 RujQ==
X-Gm-Message-State: AFq9FYKyAqcvbxww4YcEezrixlxxbyiPQ2LCPAiFR0QwsbuY+xYGp2De
 DPzjlPYvmjY3ls90tyfzXgpdXFEkp0wcCxmKg0LLMpo8kvb156sU+47TpP0ZBdyiWeLrUhZjLJ0
 k6gWLl/V2xvRTjszoqRb9xTJny2yIMqdkhQDM2eXty7a3xhkaukzrCIpo66USY2DRQg==
X-Gm-Gg: AYBFou1e45QWLVvAenotWom8R+Bx4KyLrG4Gv4pYtpjUoi7iOerLXqNPVmPKNXajJAc
 Ha+7V3J9w2SUqriDFfWR0KeDaeHrKiqA/KD+ujY4VpihwV4DIArpxb4vSblomUCX+2qYEZuPpTF
 p2l2w3HImdpdwahSrlHwB5FH9h1Ej88EMS/vI56g7KWj8qsHBjaNPdZQmDIIgrf6cn3FsIdr1HY
 eU8UUYFdgY3ZDiOAs861XJ2fHLeGj0JXThxBeOicLdnM+iImGcyTi5OoFZDaOytVIAEQGTmDtSV
 QQ33RWxGYonjEw12/4Swht9K9M3k4cVN1uMGakvMS36LjzSaz2LeOtz4zAp+sWVoueItK58/r5Q
 tZhVaN6pVODH/lUDcd99Vxmozy1s7paJ9fsOsoxUaKvHARVW5CJJNbMfLayozNArvklyWhccLRB
 6UucEJWxbOQ1nHIcf3dHxt8EBVNZOVZuon+wTU88YdBJY=
X-Received: by 2002:a05:7301:a08:b0:367:23b6:94e1 with SMTP id
 5a478bee46e88-369e861e0b3mr12556454eec.41.1793048995974; 
 Mon, 26 Oct 2026 14:09:55 -0700 (PDT)
X-Received: by 2002:a05:7301:a08:b0:367:23b6:94e1 with SMTP id
 5a478bee46e88-369e861e0b3mr12556421eec.41.1793048995474; 
 Mon, 26 Oct 2026 14:09:55 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8ee72c0sm42152965eec.29.2026.10.26.14.09.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 14:09:55 -0700 (PDT)
Message-ID: <42a4f687-d066-4a65-9dc8-a87bcbe0fba3@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:09:54 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] releases: build and run any QEMU release easily!
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 mjt@tls.msk.ru, peterx@redhat.com, Fabiano Rosas <farosas@suse.de>
References: <20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA4NCBTYWx0ZWRfXzs0K38CyLXb+
 DRunKuxWwtTVG2lUOLrKjUb41kYVBj1X2XUM7CLi39JppuAW2v+TmetMScNHiJ5aYFAtxnCddtb
 gajVJrFg7t68mw+EYULa0lXHq+k9noQ=
X-Proofpoint-ORIG-GUID: EvhwmhXwab-YVPi7BgPR4QwNgUuW3NfA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA4NCBTYWx0ZWRfX+I/AYWFFudwG
 6uDXsSu17bGPMpaEogGZoypzE6KZxtc6qJh2ghwPwKsIiUeG+sCcuc3njMn/zGthgIV3JcrAlRS
 wsfwCp/Ad0FQ+XjOfVAN5NOdebuNj9kiB3tOP37qmZIooVaPnK82ch2BP6AhQ/5etwmipFLRfUX
 UNKiL4I0CMj7Txw0wnVTpT/Iq1PWdqjhjMhjVzUzvJoyIrFB1e5bTc11X4BofCEsah8BgcMw8g9
 TkSUZEEKvb+3wW4f7Ui4HTX7wjuY2g9zZCBi9ade9iQP9ps8b6kYyylE42FbeEZyTRn9HgCrz5x
 vrBzVn1pEAAuqdqJB3XCoHslHrNYbsVZU/aKAKDJI2cKvq0hM4N43SFMNgVyam2SZ7qprZ/jVoo
 OP4RJX+Z/qrsqBKfizzMt96P+jh8Ts/r9cx1N6OsUJw6WmRNoCOaM99ssDB9ZqeODr/RM1DIIfz
 bEr+XUNd5qudQeIIyuA==
X-Authority-Analysis: v=2.4 cv=D93SufRj c=1 sm=1 tr=0 ts=6adfc1a9 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OIFsrwvNeoVN5IPXstAA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: EvhwmhXwab-YVPi7BgPR4QwNgUuW3NfA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260084
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sent v4, simplifying release dockerfile, and supporting to build any
version with any git repository:
https://lore.kernel.org/qemu-devel/20261026210801.179790-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Regards,
Pierrick

