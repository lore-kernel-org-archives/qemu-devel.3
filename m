Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC75BCD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 23:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZMH-0002zY-6a; Fri, 22 May 2026 19:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZMG-0002zQ-4X
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:32:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZME-0007PU-E2
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:32:47 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MGFkv33005223
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S0CkNulsYDweWsV+wZ7c4g2KUVbF2/ZNeA8a5w81KCk=; b=CRzmGdcN61NzS4Dk
 bCHMOm8iPcua7aAixzn1Lwrmd6OnOM16IrP2dmwyAfhuk35Ml1up0RgFODzprDvH
 6rCvfKra7gysTYGNbEEMnsYoffcRZ/2CYKA9aHXnE+mcPB3+mtWSwURWR7lOiWK3
 78HSWsW1Lm8fDZiX5I53vQDQs+iLpM/LuuFYrmE/3/hWho4GEq/UKF6yTMUc4mTU
 pHmY8j4EKQl8aF4hFZQ5tfD9/FXzTwFQvXYLsbEa8mHJ9PLbejJR59M++3r0w0ld
 2TPAkBhHVqByVgeO2NJ9w3WxTsPo4+R8JtabA+ih+e20M8vj2sBTn2p3EhjJoROA
 kJgXiA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eafrtc8t9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:32:45 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2efc342ef15so9689974eec.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779492764; x=1780097564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S0CkNulsYDweWsV+wZ7c4g2KUVbF2/ZNeA8a5w81KCk=;
 b=RH72j0GArbh3NRGbwtGUtIwMavBksQWmHA6LoC6G/4xDCXfs0JKBQNZfBlcy8K+vj3
 wtH2ug+FZ88OH8YkwwQ4FVcaVlUXu67e98hw72Ir7S2Bo3W/6pfOSj6brU4o4214qWk0
 lLhAA3PgxXhBhau7hU4z5SwE4jEXAeEPT+AWvX8srpUsLEEvDwX3j6G7k2LQg6IfLIqx
 sgG9Iigl4l+51NL60cbGnD/aPst5xLLSJNZLhojPkt9QFMN1Rtss0TMyrbIdpP+RnZae
 a8M0NJCX7GsuSpDPjbpzQWpALkUr/RIifArJG0bwJfgaNGjUfoJM4ZH8nlB0zNC9HZL3
 sBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779492764; x=1780097564;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S0CkNulsYDweWsV+wZ7c4g2KUVbF2/ZNeA8a5w81KCk=;
 b=KzQD8eqlEZlJV3uJSiCCDjEP16LjCk9SA/lEwVnbZkDRL1hi7UQ4qo9bkegV4Q3lis
 Erk467gxniM0jTxX0A25lyv1ot4MQJiVAmuqHDbVU/Etts74t7vnGF5AgbW+pKdj7ykn
 /r/6nGZ25PFujgs6K0dhindci7yQBtQkY8l5eUFiNUSLzPeQ3cLLgclSGYffNFrnuhIF
 IxqURUMf9LO3/Evwenv7XusIGDEyfQBuIO5NEd0xxSN4S48885ACMY9bdVrXPy53Yk2M
 QdANV9EG5LwFiUG+kKT3Buvqey+R1YTQKa83DqUGeqvd/uRSXP+uvowY9h/29RB2HwBs
 kLCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DBTPhPL8RBWcMiA06T3L0+EYM2f4XH9z8bR0NAwj7IHfIRV3jQsBsJHtMognyXYTUHg+VZkB+gFXd@nongnu.org
X-Gm-Message-State: AOJu0Yw5L4KiuXfK6jY5Ebp1F6v8x6yuYAZuuEsov9xQem4gKNGtf91Z
 kEixw8i85Eeez936wm7/IiZ9Nxm6qFaGj6ZXnf9gj9vZdJd1h8nVT7J9jxrbh3XFQBpLH1tSEqu
 ugkow9wrXNIm4hbbb+Hq2NjioIOJ15b/mhA+178Bh6uG9BDnlhsf9XvMgzLWRpKbjjiRY
X-Gm-Gg: Acq92OHCDlVTBwV0YPjpoVVc0TLAxPWlKCLc8Cz8iZv6bbKoBWpBNx8oET+rU6N6ty8
 gEfJuuMJ/3Jmm04bEXIOD0khnRSNKT/YiNSAExW7wPJ0lFH1L1QI0knhb5NNPQ0Z21b/KKlHFPO
 X4X29nK2x4RWqZo5VdYr/XJL0ZkkGi9z1vk7/tlR4IA7dpY+jiOY32v+TJ+rrFCMb+TGiVp7HGo
 iqtWBNYGOpwOFfwZUF2bYsE9u2MQw1pihPErqGvSVSgV+DFJjzTcim7pIhuPdbtKLixJQceDMeb
 b0JkejTCfMfLko9RkKYNTi4WVeo9YfTWP9SCYduJLJVaafEcsbZq4GvKdgyAQePu+laqrKZkmh+
 Uwh0A+TJjmFIfz2WpQ68bxHtmivZrhk0o+fu1RD1p2vJlAZ1AQ0P/C/ljmxW5J30WOBiCyllPjf
 io6TNC87A1t+CtdA==
X-Received: by 2002:a05:7022:493:b0:134:a6f0:6f08 with SMTP id
 a92af1059eb24-1365fc6e6a8mr2109655c88.39.1779492764254; 
 Fri, 22 May 2026 16:32:44 -0700 (PDT)
X-Received: by 2002:a05:7022:493:b0:134:a6f0:6f08 with SMTP id
 a92af1059eb24-1365fc6e6a8mr2109640c88.39.1779492763746; 
 Fri, 22 May 2026 16:32:43 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a40187fsm2356632c88.5.2026.05.22.16.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 16:32:43 -0700 (PDT)
Message-ID: <a564fcc4-b5fa-45d0-bb65-3305a8303b1f@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:32:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/37] bsd-user: Add os-time.h with clock and
 time-of-day functions
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>,
 Sean Bruno <sbruno@FreeBSD.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-17-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-17-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JN0LdcKb c=1 sm=1 tr=0 ts=6a10e79d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=6I5d2MoRAAAA:8 a=pGLkceISAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8
 a=OSV6RNcQlJSlsS42xpMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzNCBTYWx0ZWRfX1GOPAJUUoGWn
 gmusE4sK4795mptTrqkYAn6su/ewuXRYifwZqrdKRo2BZ3hGkGdGe802uNDm8RdcXWadprqa6sr
 LzOj+X+I8QO+1/FrFnFF+HmnbdY1QRD6vLVOEtyzEEauhw25DzmJwueP5KJA7IxLKsx2icABM+W
 0UehVVzdM+9gSw8O7UxHVhkjkQtGfPNfK2ZU8iDNxTtfOSL78TmPpq4mdtoZI0t9LqtAalEOC/A
 4BJz0AeTVinvg5xpY9QFyauIvS2PegBzViW9mbDIoLd16JrmYMFGxIqDj9sspioEJYrwAEgtzlW
 TwkhA+z2XvDSyNbOPb+3uE1WCsvqO6QAax4dHAW+mBMMbWTPq7YUqm4g92YqXONET3Saae8HDnr
 uF68p4Vb9rpf12ADMmZ2ub7tOiR8WRWaZ94oskKG35eu3pUN2g7cIoLZ5LzeQTBRjLnMsWMxTXO
 qEYmwzlhyKy5V5Xhj0w==
X-Proofpoint-GUID: GbVk9YB_4TwGvobVyFlqiuYFa3dB8MWO
X-Proofpoint-ORIG-GUID: GbVk9YB_4TwGvobVyFlqiuYFa3dB8MWO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220234
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/18/2026 2:27 PM, Warner Losh wrote:
> Add the first part of FreeBSD time support: nanosleep, clock_nanosleep,
> clock_gettime, clock_settime, clock_getres, gettimeofday, settimeofday,
> adjtime, ntp_adjtime, and ntp_gettime. Also add safe_syscall wrappers
> for nanosleep, clock_nanosleep, and kevent.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/freebsd/os-syscall.c |   9 ++
>  bsd-user/freebsd/os-time.h    | 221 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 230 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

