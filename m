Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2C1C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD3K-0004wi-DA; Wed, 26 Aug 2026 08:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzD3I-0004vI-VZ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 08:48:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzD3H-0000ig-En
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 08:48:24 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCCHp51223169
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 12:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8eLgQFjgTwZ3fUs+K5OkmbSxkwfAU0hbcyyPL3l+Sz0=; b=eWxBVfF3W3Z3TnLj
 WdeeMit/5wi9m0iBgHeC42mKZym3adhVVPEf41Dj7oyhRqizmYb5z3i2TuwIMSlW
 HBqxMFdWSv9CV0TOPZ6ItAVcqdJZer+CUZEJpV2xdqjxIq92vGE8ZbUfRqGVdaMM
 rOeih2xzBPreqvWctFVZFV85lyiv4gfufgtBDC5M/znrYUVAoAjxDEqyhiKQZmMA
 pWHB3AC9no2rNFL8ydiop1m2FAWl2o3LaILEJAU7IJ371MqcfWua2+0z/RD9UZM2
 Y1/aDm5ttPMZHBBNj41sILXBHmDLuqMWG8I3icEyEF9tzGHvZfYJmeJD3n/7DjGI
 mLCjpw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r1gj3aj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 12:48:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0e702df8so12854511cf.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 05:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787748501; x=1788353301; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8eLgQFjgTwZ3fUs+K5OkmbSxkwfAU0hbcyyPL3l+Sz0=;
 b=Op8oD1e2ODiRZQndiRL/toBIuqb9+NBlYiA5ubERBoiwfXJY0OZcm3zh2Oz6zicm4Q
 NpXWOuVKXnNlKwo1ElKk9+A4MY5hgl5tDyB7qDYchSNflum3seiXPHwj9gwuq6j8mSZW
 1++JwzTSVtHiYmgrv+UrRJiWq+2uoI6F6NWsNG68T5wu/Xaow/GeH4Lc3d3Vvlab7wpI
 9k5AOCTg47+GBt2f+hD7nW9meWJ7tIk/ScnCnVAWisBh+Ok0YDE7m9+cyftJADt142Ek
 3singMo5lS0gKZodI4YqASQRqLBbK9RXJEGzjRSwhtNXcg4yljlDvrR2sfhwEgXAj3eN
 Rphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787748501; x=1788353301;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8eLgQFjgTwZ3fUs+K5OkmbSxkwfAU0hbcyyPL3l+Sz0=;
 b=H8JNksvsEH1oruCydaahyvcfTqqt++/pLCW+uW+C3YXXO0NB/EFplFEihRhTK9JXXF
 xVPYKECkd9ozAR/QCHmDxkhZV5lY+dAN1jROMo2KFH5UhNFkmz9IPLHwc/vUHd4GGZkC
 KIL2nds6H1YYqMN34M8AimmBaaJIKnWo+i7M0U15KZXQGH2ycFp1ZFFbac1CtZ9fDcb9
 xyNzfOTdiqUmm4TBiA14CRifowSkKUjBKXGzK5H0EC37kWNHkwkqkbptJk3N71oFHNaH
 oeKGEYlTrFslsv4RTwUfL67nxW0dq868E0+MKtCsR0TnPne8sPznkAKUPklxJpxP/b8c
 v0yA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwdtjlCfPURQ9yHmGNX5QRrRrEcfLN6tujjZUu9c1JWv8h2u8mDvo4b3GX3ImKh3xCTGblBJL1B0FX@nongnu.org
X-Gm-Message-State: AFuF++mHF2bHujJEMkB7o6ULv5oeoVVHMmF++GZ1NIjPljA18NQsDJ7z
 +3rx0gGv43HOHpjj4kaoZmd7YbNrD08c74JnbrDMH2jjlIQVaVXnNUMG1CWP4igmpwh2+0gDo7n
 9zBkbgUAt27JJIQI1C1+cktI3XAjmEBVff/ri+fN8bkQE+C4M+JGJHL//Ug==
X-Gm-Gg: AR+sD13U0Cb8wOl/5egn7Y4vW7SYAMknDody//AyHSQQxC954CdJt93cNTWfTqFPfCP
 UFeAM4iYDskGRYn4yabZPX5qUSiyCgY8pV+gi9IK0aYOqvImHbufHGQsT3yAHPStHIUasyhh/7k
 c8HhyCrHwTXYCrlbsFJUdcQzjQeruCyAm5ZY3Avkr9fyNNs1mOPIN7d2sytkLagJpqkptKhJlHb
 i9DqjsciH+bJdaIisn9hDa/Z1VxdGULsf+m7Rzs7Y+DZRaCSsBW9EFtvE75MTpMsvqvR1ZaiRl7
 iyGkom26NVxtB3hfszrDlvAC34A0CrRMYQw0Dzf6F+lemuuGeA8n/G0ndJMzxShzP9SvCCezAuB
 FEXB3uJRvcKjUHPVNFkqx
X-Received: by 2002:ac8:594a:0:b0:52d:953b:2c25 with SMTP id
 d75a77b69052e-52e423cf77emr63501931cf.38.1787748501464; 
 Wed, 26 Aug 2026 05:48:21 -0700 (PDT)
X-Received: by 2002:ac8:594a:0:b0:52d:953b:2c25 with SMTP id
 d75a77b69052e-52e423cf77emr63501441cf.38.1787748500983; 
 Wed, 26 Aug 2026 05:48:20 -0700 (PDT)
Received: from [10.254.188.74] ([185.104.138.96])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8d21f8sm4484046a12.11.2026.08.26.05.48.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 05:48:20 -0700 (PDT)
Message-ID: <6b7a4d81-80b1-4612-a625-ef865fae4f19@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 14:48:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/49] qtest: add qemu-io command to the qtest protocol
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: dave@treblig.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-22-af60857c2fbe@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-22-af60857c2fbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qeq4zCsjJi-gdKnlPRWs-qduNDCf191c
X-Authority-Analysis: v=2.4 cv=FPMrAeos c=1 sm=1 tr=0 ts=6a8ee096 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=KRlTYBX1Q8J3JuxqD7zILw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=SOhxVLkd1rd8Rc2eKy0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNiBTYWx0ZWRfX5xNArSNRbMHW
 TyRIWnPPdBDSoxiyhwOPW8/c7qkIW836KDYEd5YZcYNMkRzrU5o7+TjIfSzATdKTqlNFbE3a/ky
 dmY4DdImTJ0nN2uQkto33Njvb10ew/w=
X-Proofpoint-ORIG-GUID: qeq4zCsjJi-gdKnlPRWs-qduNDCf191c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNiBTYWx0ZWRfX/lzkkyapv7tS
 Dc0jGHW3GVKK4hE8HRobRrrLT7mRtNZm8y6qBjH7aO0HhOI8heRPawUDUI9xlJvzfPOBffOibna
 Tzgz15Mk4bY2sLFMuUvBm//njZsC43FqarNqPHjfWQGl8D2dOosMqsMMNtPRyys4moMBo7MZt2G
 kC/9ztdWeX3jPzyJn8hIV9xtuJ00EzHEiim45dfFL+/pMFcChuHQidGxf/An9HFWl94/saQlw29
 q1hQ4sWw5xPKQZXgfzWn91Vo/T5PNIXICo7j2nTJ64v9G2o1VkZ7JhMyXNYpu4St3CbKcv6FL3c
 nndO6sAUU2SA2woeFn6Gyh/Rmd/TSi/jW5D5KyIVl5m/7NVFnwgtJjAD/+yJET95KqSnDA9kOkA
 SEzaadmyB3tibLlLHnPrejTwIaWMKy66jsLRygOwz08kn53TwrWRaQ6+BdA4CXZQxPBb+9kGlhB
 eIGaYWAwVGOymCTxvjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260106
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 25/8/26 21:09, Marc-AndrÃ© Lureau wrote:
> Add a "qemu-io" command to the qtest protocol so that tests can issue
> block layer I/O commands without going through the HMP monitor's
> "human-monitor-command" QMP, or use QMP at all.
> 
> Unfortunately, many tests will prefer to use QMP as they also monitor
> and log other events. It's easier if it is pipelined in the same stream.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   system/qtest.c         | 14 ++++++++++++++
>   tests/qtest/libqtest.c | 14 ++++++++++++++
>   tests/qtest/libqtest.h | 11 +++++++++++
>   3 files changed, 39 insertions(+)

> +/**
> + * qtest_qemu_io:
> + * @s: #QTestState instance to operate on.
> + * @device: block device node-name or BlockBackend name.
> + * @fmt: qemu-io command to send, formats arguments like sprintf().
> + *
> + * Send a qemu-io command via the qtest protocol.
> + */
> +void qtest_qemu_io(QTestState *s, const char *device,
> +                   const char *fmt, ...) G_GNUC_PRINTF(3, 4);
> +
Again qemu-io is a CLI tool to send block commands via command line.
Here we don't call the tool, we run the command directly; that's why
I'd prefer qtest_block_command() or similar. Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


