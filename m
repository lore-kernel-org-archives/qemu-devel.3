Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E1FCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyAb-0003ui-Qy; Tue, 26 May 2026 16:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wRyAR-0003uS-6D
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:14:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wRyAP-0006jn-Hm
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:14:22 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QH0oiD2977139
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 20:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=499nKXEk2GR5GqOHbhkqUQ
 GYto0KGTU1/etBGeTi3gE=; b=bjx+B6R9fHa+FwY1y/vW3vYfoWYWNwpLSaUrcw
 Z2l6Osx3rImYKHy2em6oG1+IiNMH2lOuzQT6ur7Yv92yvC16BXf+aikricAo5mF1
 1pRggV9Xo2VXhIFc0x3sNQsfpkEKI6Aj41DEgbWcRM8/Il4waeE4n5qu1P8VRN2G
 rGl46CxGzuhEUYOItfaX9sMnSb/bHDq6XwPZux9xxmwMDetU2NBnd2/f0A9t6b1J
 klcsHAsr6Gtepcldgsm2+2FryM0M8uQxyN+kemfhzxIbphpM41/F6ZREADYRdt+3
 K3HTHvRbSEFeguK0rzQ0LqpInYejc+SKQy2Re4kV5POj9sFw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eddqksafr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 20:14:19 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8cc616cd846so65329546d6.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779826459; x=1780431259; darn=nongnu.org;
 h=content-transfer-encoding:subject:to:content-language:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=499nKXEk2GR5GqOHbhkqUQGYto0KGTU1/etBGeTi3gE=;
 b=I5r2QH0Y5/tSkBV+YWpvr8CGdexV7+4oozesLdgfriklTaolCh0vMHa5Te/Zrohq/w
 t4S5Q+K74bhdPpKhsQCyjDKDc8JT8ut2HmqZkTqmybHugGO4AY63DIT2SARXx5oAjxC4
 JbuinUWSCBv4TRSGMpBS1ZVeWtTQ4uuEOtCrLadspC/zQDXdV6DPQo+OIV3P/5M5LGGL
 9bIyBwC3caV95xGZwuPJBPvhQsy7zdlSxWt2IA3VDWSEtFJs2/hEE8mazB0X/xxo/H0r
 cbEHwfScwlMez/wKMQvDrpqqnX26wh2mNIOPpTV63F9Mpqib7Z6uP5DzBthjK3survRO
 3xdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779826459; x=1780431259;
 h=content-transfer-encoding:subject:to:content-language:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=499nKXEk2GR5GqOHbhkqUQGYto0KGTU1/etBGeTi3gE=;
 b=r+u6wCNmp+HIPuPJ8s3opMK1v8lAcEBJ/gfZTuGZdTeGtLOq9dNl1TZazmvW2fcSSa
 SBkJg4jdKbmqZhFezvwuK+L9BP2gzrXIq5xsfdBWUBl2n7tXmkoOUj7ErkqocUs93kq5
 aUYQvrPlcdJ00qtKG3/K/0aCxF2xD+k7YdPYF400rGayidV1j3m4ou+7zaDw7n2H4mbU
 f0qmFckFBpCe59Rjf8nUmXqJQbrTElgBM9bLbAvKCBFXaDWQugngCKvALYkjKDOuvjfc
 KqOb7loTJvkY2WBsKcjnQ7amaM0Hd9rnL5NZmqdnqtuRkMM6mdHQM+SNre0I8JdW+8Bs
 6ZUg==
X-Gm-Message-State: AOJu0YyxxZDxi++oDTaNcQH4J79t5lxFeI19OHbiUbA3wK9boYeInjLg
 ciQ/S2HAAelgexS4YqfxCWlaOtSwd2fkQ9HcscoJZM6UiAn1hcXoXQ6rNE92fl9ZwT3Ax1IoYm8
 2/78tbb7qjjR8OgRRQiO/kiEqoy5nGgBpynunxNVFPxMDaGd1Slrg8ZmKcQ8X/8w2zQ==
X-Gm-Gg: Acq92OHcaOdZNpEF50s5hTuAjQOVjCbtDoLC9AuZPHxJ+3/nHe0hwwJxaSIrhkWlaMM
 RJ84aRT+LO+LgUeV4oPlHLNvMCoZedrAyj0De3Aju89FwAnt1FyoGK3mKJm679TrbqZuyywcn4/
 WahcoxcFBnwzG12caGtsomyYAigrIS0KEO90+Ld2NB5RGUUcIQ/D/9YK7TEhUij9xrpF4Cs3T+g
 zSoueCJX8TpmIkFSaKXPwjycJ4Z8yK7SQ0PURJXu1ISQUfVVrMLIrQh8T/gBowBEB1Pk/Ennpds
 qbAa6fdh2hEXzEJ5EfW2jb69e0H/RaNXn9AgVimQbz3XS2a224mJ+2e8ZiqrzbiVmoh//+bVdaz
 2lkCyBtpg7goW0z20e9CRKISnz29PBhpdn9FIg6zAIjq2TK9HcVZ3BgU6fxW/1pkGyCFt4g==
X-Received: by 2002:a05:6214:2dc7:b0:8cb:e78f:21af with SMTP id
 6a1803df08f44-8cc7b521a1fmr303423066d6.12.1779826459180; 
 Tue, 26 May 2026 13:14:19 -0700 (PDT)
X-Received: by 2002:a05:6214:2dc7:b0:8cb:e78f:21af with SMTP id
 6a1803df08f44-8cc7b521a1fmr303422626d6.12.1779826458637; 
 Tue, 26 May 2026 13:14:18 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc8130d4desm154240156d6.39.2026.05.26.13.14.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 13:14:18 -0700 (PDT)
Message-ID: <0c7e5dec-44fc-4c1b-b0ce-cb9fdd6d0a5c@oss.qualcomm.com>
Date: Tue, 26 May 2026 17:14:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Question about recent iotest changes, 'make check' and 'ninja test'
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Zubd7d7G c=1 sm=1 tr=0 ts=6a15ff1b cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=D_LbBgvFBsbTjuw_PZMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=PtNt4yTRUrdAyI_SWoo1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE3OCBTYWx0ZWRfX26wyDEWFfI8T
 uNoAwfhFu/Hyn5GWS5XhKOiP/fJna+666QJcK8n0ssTo1u9JFbJtR918tPL/muKma9Wx566EJDJ
 y4I7WoMwkB7/Q5/JGlkRr79A49WyV3v4EEDyLofzQVIDZVHpmJrSf+9C0PtiV5vlDTEe8H+3Ew4
 aTAS0aEJHyOkwf89hDXIyqEfpgpKDqqCUSwEnQEGf/0I0+bNm7JKdm/QYs+UbrsicAjVDcxgj/l
 pnyYvjB59k8CHPJ7mmVbjAnrn3wa130Vi2vqEKvNBbLjw+fZE16J+CMFLupM9qzjU70Apc5GRI6
 5KH2UMskPzLSLOJ/h7llQkqB/8w0Ti1JfHNIBiUfc/864r6TnbMrP5oibYyguWMYpwqaqX/GCe3
 aUWIMXXB4WDWACTXHDp9sGwrOR+eT/8v1fQYYrWNYYwEB1PsVWN5WcS4oyD7Sjw0/z7iU1AlbsE
 IUtPRyjyJjQFtI2H6/g==
X-Proofpoint-ORIG-GUID: jwRVhiIFvov8Q0gXeJQOXq7vny5plFZu
X-Proofpoint-GUID: jwRVhiIFvov8Q0gXeJQOXq7vny5plFZu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1031 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260178
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi,

I happen to use 'ninja -C build test to do a (usually) quick sanity test
on patches and changes and whatnot.  An usual run of this target tests
around 327 individual tests with the RISC-V stuff I usually build.

After pulling today's master 'ninja -C build test' is now running a whooping
1366 tests.  Here's an example:


$ ninja -C build -j 9 test
ninja: Entering directory `build'
mkvenv: checking for pygdbmi>=0.11.0.0
mkvenv: installing pygdbmi==0.11.0.0
[2/3] Running all tests
[1-12/1366] (....)
  (....)
[250-260/1366] 🌕 block-qcow2-optional+block-slow - qemu:io-qcow2-014
[250-261/1366] 🌖 block-qcow2-optional+block-slow - qemu:io-qcow2-014
[252-262/1366] 🌒 block-qcow2-optional+block-slow - qemu:io-qcow2-026
(...)

I noticed a lot of these "optional+block-slow" tests being ran now, something that
wasn't happening before.

If I use 'make check' I have the results I was having with 'ninja -C build test'
before the recent changes.

I tried to bisect and got to this commit:

commit daf0d008822be3cb14cdb533f7237c3c789bc373 (HEAD)
Author: Daniel P. Berrangé <berrange@redhat.com>
Date:   Mon Jan 12 13:01:49 2026 +0000

     iotests: remove redundant meson suite for iotests


 From what I can tell this commit triggered (unintended?) stuff that was already in the
code.  In other words I am not sure if this commit is actually the culprit, so I am
reluctant to even call this a bug.

My question is: should I be using 'ninja test'?  It seems to me that the common practice
is to use 'make check' and maybe I've been using an "unsupported" testing scheme.


Cheers,
Daniel



