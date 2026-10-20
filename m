Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A9606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dbOP1ZZh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XSJyf5kw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFL3-0008Nv-UV; Tue, 20 Oct 2026 15:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFL0-0008MC-J2
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:17:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFKy-0007A8-Ep
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:17:30 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KGtW1R1375705
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 An9n7ZMORIErqCT700BKd3StIH9lgEegyt4NQAd7Li4=; b=dbOP1ZZhvwAeR6tq
 fU/wCrzZkxXoGIrXpaTv/+GQn/oI8ZS/t7mXYv35I+mazQwDG90FVBVbZXHlflNl
 O8Nq5rOonfuwlkrdI8gza7LbAuLHxv++qQlAhU7TAkTkquZVObFl90nWB3slIxB9
 CMQ6SIIQV1QrqEiE5hLFRWXHS7BxKlQzrwK1X7QRdGODvb9XAI6/2RY5ofDsmlYP
 WIcTQcx5bY/81w1Y3BOb+8fknC5+lIHgu7FtqNxFYyALs59qcbpHvEqRQ3wYJqaR
 +5HKGj75QcLCa/Txoz7FIGm66Wk0QBb60eG7lcvW1jJWV8RTfDbx0eFSeyPi/XUP
 aGaiqQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hebyd0m4g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:17:26 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3662e7a9299so51063eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523845; x=1793128645; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=An9n7ZMORIErqCT700BKd3StIH9lgEegyt4NQAd7Li4=;
 b=XSJyf5kwbqhTfWGPxTTn0KYIDUeRIF4GxtT3giOFpT5WAyVKN55pN/8trdT+fXdJxR
 DbWYVFRJkh4lDg1ifcnFeu2kiTBSIoHNaeOcuK1OYgsrT6KdZAS9a+rGVZU5vvwSvI/k
 1DFgreBp54iIDl23UakStMo8aEDyAT6P7p4HWC0o/n5YAPTnt4LB7UJUck9w0IAIH0Kp
 S4TCBXryPT2qBN3Z9G8BOid6ZbMdIhDCtA4O8Qa/eMQCm6cwh7lTRvm6nq5x9z7i2UBn
 0FvBAqhv7IrPBvEjsZvSqiM0y2WBYajoeVxJug8zWs/uvURklZhTiW/HWKKd9KahVlxF
 +3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523845; x=1793128645;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=An9n7ZMORIErqCT700BKd3StIH9lgEegyt4NQAd7Li4=;
 b=aNptz/Wm/o4JUscst5IyBOMsIsTWEpU+UTpBogsGTsr/KSFaUVEOLdL5Nx5gNEBDTF
 57SwBYSbt1lHiWqBekgvGOBSfgzev8o4xi6I32ynNYSsEytYL412o0+iDp+wABkGXzus
 naEGveALDlC1ZbEn8f2m9l/s6SCn9LQBXZq1w2zPOn6UAvlKAC0PTRo0f3ijqVGOw575
 OuGG6yynOyHK0/e3EYiAnCMOkREI+S/7OI/pnvWBC4uNXWW6c7dQxJrhPtYUMZKgUPXs
 Al4WiqAVdlQTKVybJB2NsJ4k3ozedNAMhS97ZHsdX/viizBM9lQPD6zF6ZBXb4bjhHNa
 K9ew==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwWjoZrnAzMaGwjIXn/8I+sJhua1DarW4zUoISmbMTcFUMep9/2Xt/fv4fhjnNE0GOaT2TL2wDo9xL@nongnu.org
X-Gm-Message-State: AFq9FYI+4svp+qy2xGbiE4/9ZQPJF4Eak2eZPWV3CprqjYthUfQhGIPR
 SZ0XMdbeSjCH7CYu/SJF2FpqFvSDPU/+VnbjKkdxDOw9J9jivQg/Z5GpKsKUnwXAQoNzhePdHXO
 2sz5Gkr03i4qGM9drnKWRx9e63Sv9jbDe1GWyFOe3VoNIAZ+6tFsNa1b2NQ==
X-Gm-Gg: AYBFou3zwAsgY7AKfST8CYbWNGoMsG+MHZA8h74TZul9VFK4GIvFZWupX5GF+lFRN7N
 JYLCivMrAXiIxrIawxUA4jJ/yEVOdtmmKfgxXES52NJcHjb38oL7LQCM9BzCA7gZJoZO43M1+uU
 PgBgt+cKiWhWeUX6X9Jm3R+OuCFIZlI91q7gxpSB82isklbQiSDZ7holV0HFqNWbx2Cz9qvfkHg
 QO/iZdbdIfv4js+LbFeFW1LnA1oZQfQry3QiKebb6vIHvV0wl+GRwbMI/tWZ0XnNZbUsogCccw1
 zRkXkewOMQ3ctzhwS+Olr045xbKMUNn+nndatTTV54/pTHUP+Ax5e0D5k7v2+v3Y/H1/joIkLoP
 0+mRzFx7Ly9WQ94+oMncS/xByQfFH49ekRZ2vWD3TyLieLv5saM3MVdXQgYN11LZ+Q2jqMA==
X-Received: by 2002:a05:7022:ea44:b0:181:83c:5df8 with SMTP id
 a92af1059eb24-1851238b3e7mr15997138c88.11.1792523845273; 
 Tue, 20 Oct 2026 12:17:25 -0700 (PDT)
X-Received: by 2002:a05:7022:ea44:b0:181:83c:5df8 with SMTP id
 a92af1059eb24-1851238b3e7mr15997110c88.11.1792523844653; 
 Tue, 20 Oct 2026 12:17:24 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903d3ae06fsm579456c88.19.2026.10.20.12.17.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:17:24 -0700 (PDT)
Message-ID: <95806d8d-ae96-456d-b658-fc491a31c127@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:17:23 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/27] target/sparc: Register CPUClass::exception_name()
 handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-26-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-26-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX5oE9c9z1A5MM
 t2WMxTxVc2l1TcvA3zaUEiO7qs65+MsG8lpLgiKCVlaeK41ErmgjdAqaenS4RqqRD8FHt6H05MH
 pkHPNgP5Y/dyJ7ncs99oAMK/mwNv3YzWqbFaead7j1G4/bGOkXWaVRYVR9SBBlsLBzRMNM1zzlU
 tleaCa91NVQDlG43+/PvDW8pVh2sSKsaCdSiMs+mZ87cqg9Aw0OaSz7s+coTBoCb0tJT/QZoQCE
 NS9bGMKiker19n/aWM/PvoTbhBNkPIIOrgkTwH6nDhctvd2Kozj07UF8reLjVtnew+Kt91Qf1aT
 8NOxjh/dQQHPKtspj5fTMSK2Toq4xV+Vt4/fA/xgwuVvGMSx0p6mh6mlfInyCNtmaXJvAEMi8dN
 uWPEtdUczd4Yd8VoB39punt0DHGRASadq/krfakYBbCHbrLTlnCZ63wiE/a3ZzRJhjGaVXoBP+k
 F7Ck0U+S2nBdZXXK6hw==
X-Authority-Analysis: v=2.4 cv=TdsDJhQh c=1 sm=1 tr=0 ts=6ad7be46 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=N5cLSfySk3iSLJ1ri9kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: FNpdOGBRgX7caAGkNrlcW60h9PXVC2ce
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX5b0/7wpkxQ6u
 Jmg20HnKLaxZX5CChYNWbYnnsOj/5RJaSVL0G/0uLHq614kYLcqQ2A8TDvZEzWZZBKhzZIUJfe3
 YAiZ2cGoDp29Cz4n8MTdvHhp5W1M+84=
X-Proofpoint-GUID: FNpdOGBRgX7caAGkNrlcW60h9PXVC2ce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200076
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/7/2026 2:45 AM, Philippe Mathieu-Daudé wrote:
> For each SPARC / SPARC64 target:
> factor sparc_exception_name() out of sparc_cpu_do_interrupt()
> and register it as the CPUClass::exception_name() handler, so
> the common exception logging can resolve SPARC exception codes
> to names.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/sparc/cpu.h          |  1 +
>  target/sparc/cpu.c          |  1 +
>  target/sparc/int32_helper.c | 23 ++++++++++-------------
>  target/sparc/int64_helper.c | 36 ++++++++++++++++++------------------
>  4 files changed, 30 insertions(+), 31 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

