Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDC6CD6E40
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 21:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRzha-00009l-Jw; Tue, 26 May 2026 17:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wRzhY-00007t-EO
 for qemu-devel@nongnu.org; Tue, 26 May 2026 17:52:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wRzhW-00013S-FA
 for qemu-devel@nongnu.org; Tue, 26 May 2026 17:52:40 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QH0tXD2022364
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 21:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eXV7gAWIKGtaJN1JAqYcglBkX6NNJT8Nw3+l03XtfjY=; b=NYpdC8+xLS6eWX3L
 7DoIjM67JmFrspNRlZzDnVqUnBwsVVEx6/zoTDKf9QaThg7suZ5wSXlL6knjmbjL
 WnLLK0C5bVoKqf+YMJaboCX9xOzz4HgIW81QvkHagfWGj7cZja+MKp8xq/qyKT/E
 lW4kQtUGqHJgTrcJXt122pWOTezoX23Vg4gQd/ubGa6TNsvWS8IVHHa9MG5g0egN
 ZgJqpbuMv5kFQOXZdvnVSrEQCgSCHiKWvq4FGbaV8AmCewZ4VC832+VRU5vV4gXY
 n+n0mLPC1ld7fCf1I4xS529s0difJKcj8lTQINXuGA+/J6B1vGcrUhPHF1jXoZJ4
 1Ul3cQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edefuhcrc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 21:52:35 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ef62078ee7so143181eec.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 14:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779832355; x=1780437155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eXV7gAWIKGtaJN1JAqYcglBkX6NNJT8Nw3+l03XtfjY=;
 b=YJHHP4Z1RvfWMABpEGXBQvzp49hwvvsj7TBWU9IQDpBCY6vy055oG7L6tbbl8wZ4wx
 fNMviCLKDMkELaEn99wTgaxOv6ozHFonbRwag0ebbX/J0uGwwsTPJIJuY3Xx2S+DkEjQ
 /SLHC61HLLroZg+z13mD9L91wSy6N8GWv5SYF031IURPZM7sn+GlljuB33dMEHs7PddP
 28yzEAjT4jMW7e3p1dweWhCIlU7ykgWvHpBMb4fIRGAIDDpxbunHLKC+Gjya/u7UuJjV
 cKUYQ1M/R89O+N5JkQKZXDd00qVbQKVXlhbLdeCDAG9VW9WUk8V0PWdzBJEUvlTpP6Mg
 63PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779832355; x=1780437155;
 h=content-transfer-encoding:in-reply-to:cc:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eXV7gAWIKGtaJN1JAqYcglBkX6NNJT8Nw3+l03XtfjY=;
 b=HYDLzTKgz47tTu7v1/Zr9FzlipXFivLGPTba71CMXwH0YE/q1n8dGAXZAfh95ZZJ9C
 clZLnmRM0Hrbl5CeDb8vGnr/2PGZhUNQgaSgfetwDNTEOFQHfHLFtK57w8AkBUIkZFcM
 bTMHr7GvUvaZ6qek//ltKefS8FYcWFfo5HpAKMiEf2xb98c032Vn82SLd5UADuEwG3w7
 uIHENlria73miHkzQ5DFLuvyn2V74AAp6VXiewl4K8fre3L1plCDL1ChKKiMaRsdxfOL
 /MofitMUim0j8+dRZUw1bnMBpq+Pn7/KUMHBY2xv9bUFCDC6sNm+GPKDvi8hT1lNrSCt
 eo8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/o+zRF7vS4Eskxg+6omi8CY6XATdBYFwywi+796UscOQtWSJOCrsxZd+JBQ2keis96cg5PcqEkqG7Z@nongnu.org
X-Gm-Message-State: AOJu0YwQdhk8GpU+cEGSQZw66/xZLj14lD7ATpyMKcSzqGVdT2jiyxZv
 6gPVbs0ncdwFexKnbKctNmnRWBHcAcssgdiuswOU5DCZ1Odar/Q9jlcEc0RdOfpEMRyQWSenMwb
 7jxQhHXPoJS5s/GHD4HqvA/4q95BK07KTWnGcCP1WjTodJI6ax5g6dLOZng==
X-Gm-Gg: Acq92OGTOtYF1eQgusf2zVBDM5f8m8HVvvpMYFIhl5jfvA0MTpOitwPZTR+qYirektL
 UjJZZ7xuz4S0wI9xD10+ulkNEdBHWJwVBpstYQ/7XbqPcLZNbG+d9fiEBcawdBiqQytidYebbyU
 eNRG7psn0B/ljT7QALGW7wCuBoaeM95acSWNA9HV+PPLJbKOh3IgqxRYTCd1mH92d+QCSH5gn/N
 /kXMISZAudlVfoAhFYEm7A7+22bbmBNfMHen6sGm94O0YdJPc0NwlH2ViOcK+wAF2eLppWjn22Z
 WuhgcgouzWUK5pWTRBukVhu5fTKBK4BFewVDyrt2a2sRmxoDpcy3ZLVto2npRo5KiIkzEEvsb1A
 CoLUSm5RgXMe66cOYjogpULYyRtVm8yDiETuGXN+BGB5K7Wd0/FQr4d6ZQwfR9ooB6EMa/BNoy6
 O9pJksWPRVgwhKaxkgF80KOKMQ
X-Received: by 2002:a05:7301:9bc8:b0:2ed:6f94:9d96 with SMTP id
 5a478bee46e88-30449183270mr10026448eec.19.1779832355002; 
 Tue, 26 May 2026 14:52:35 -0700 (PDT)
X-Received: by 2002:a05:7301:9bc8:b0:2ed:6f94:9d96 with SMTP id
 5a478bee46e88-30449183270mr10026427eec.19.1779832354310; 
 Tue, 26 May 2026 14:52:34 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304522314a4sm11094326eec.18.2026.05.26.14.52.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 14:52:33 -0700 (PDT)
Message-ID: <9c934a2a-2cf5-4604-b1cb-7be0be5307b9@oss.qualcomm.com>
Date: Tue, 26 May 2026 14:52:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about recent iotest changes, 'make check' and 'ninja
 test'
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <0c7e5dec-44fc-4c1b-b0ce-cb9fdd6d0a5c@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0c7e5dec-44fc-4c1b-b0ce-cb9fdd6d0a5c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE5MyBTYWx0ZWRfX2GDVX3fluGpm
 Er01UhwRkPZrKJ8W6ydK/n6zMtzHRiAKnY1X4ig2PfQrjr7uIGU3K6vKG7/Vf6O+ipn82U0mdw8
 GTvv8igt8FU8Bt+jbexY0VxNSA7vd+rOSfRK6UaFKYK2PlIdeRiKHDF/7Y4kDTF/tID+WTBbtTs
 3dWopuUGc83WtyMoOjlCZ7RL9w5Tcy1SpWjcT85GQRrV4kq+35F8s0tY8zyL7duvGG+eB6jXXti
 z+plIP9CEGeDWEQ9vZnY+S5ya/MLoArWh6WxNei3HcBJ/RSWmwCF9s8xUZ6TLxhy9in6vH3IofH
 cNRLf4ogZm1fo0yHrDddsphx1twtEZQUEK/sjO89kJM4xlfh14ViEmQ5991yD0dsPeaHNskXF+Z
 0Fdlk0+hPxjnJ+rWEG46fhoEg+CLPa5kZqn1XKCtkBJhpGq4EOWqfsb5dobAdR5m/QwbgJBEfoe
 RjYNxzjWEtt82ulic8g==
X-Proofpoint-GUID: NGQdKjro3SyZWpZ1E5H2JypeeSIdHV1_
X-Proofpoint-ORIG-GUID: NGQdKjro3SyZWpZ1E5H2JypeeSIdHV1_
X-Authority-Analysis: v=2.4 cv=cPnQdFeN c=1 sm=1 tr=0 ts=6a161623 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=sopM5eL69hIQNRWFXEYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=PtNt4yTRUrdAyI_SWoo1:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260193
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

On 5/26/2026 1:14 PM, Daniel Henrique Barboza wrote:
> Hi,
> 
> I happen to use 'ninja -C build test to do a (usually) quick sanity test
> on patches and changes and whatnot.  An usual run of this target tests
> around 327 individual tests with the RISC-V stuff I usually build.
> 
> After pulling today's master 'ninja -C build test' is now running a
> whooping
> 1366 tests.  Here's an example:
> 
> 
> $ ninja -C build -j 9 test
> ninja: Entering directory `build'
> mkvenv: checking for pygdbmi>=0.11.0.0
> mkvenv: installing pygdbmi==0.11.0.0
> [2/3] Running all tests
> [1-12/1366] (....)
>  (....)
> [250-260/1366] 🌕 block-qcow2-optional+block-slow - qemu:io-qcow2-014
> [250-261/1366] 🌖 block-qcow2-optional+block-slow - qemu:io-qcow2-014
> [252-262/1366] 🌒 block-qcow2-optional+block-slow - qemu:io-qcow2-026
> (...)
> 
> I noticed a lot of these "optional+block-slow" tests being ran now,
> something that
> wasn't happening before.
> 
> If I use 'make check' I have the results I was having with 'ninja -C
> build test'
> before the recent changes.
> 
> I tried to bisect and got to this commit:
> 
> commit daf0d008822be3cb14cdb533f7237c3c789bc373 (HEAD)
> Author: Daniel P. Berrangé <berrange@redhat.com>
> Date:   Mon Jan 12 13:01:49 2026 +0000
> 
>     iotests: remove redundant meson suite for iotests
> 
> 
> From what I can tell this commit triggered (unintended?) stuff that was
> already in the
> code.  In other words I am not sure if this commit is actually the
> culprit, so I am
> reluctant to even call this a bug.
>

Recently Daniel sent a series to enable more iotests, which is great!
https://lore.kernel.org/qemu-devel/20260521134943.1714527-1-berrange@redhat.com/

It seems like a side effect is that they are default now when using
ninja -C test. They should be correctly filtered if you use make check-*.

> My question is: should I be using 'ninja test'?  It seems to me that the
> common practice
> is to use 'make check' and maybe I've been using an "unsupported"
> testing scheme.
>

Officially, it's not how we're supposed to run things. I asked the same
question a few months ago and was invited to not rely on meson testing,
and thus ninja test by extension. That's sad IMHO, meson interface is
much better than make interface.

Looking at build/build.ninja, (grep "build test:"), test target does:
./build/pyvenv/bin/meson test --no-rebuild --no-stdsplit --print-errorlogs

I prefer to use meson test, since you can easily list and run specific
tests.
./build/pyvenv/bin/meson test --print-errorlogs \
--setup thorough --list

I personally always run (well, I don't, GitHub does for me) tests with
thorough setup, so all tests are ran anyway.

> 
> Cheers,
> Daniel
> 
> 
> 

Regards,
Pierrick


