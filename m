Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C10CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMpG0-0005Px-J4; Tue, 12 May 2026 11:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpFz-0005Pc-9J
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:42:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpFw-0005pB-AL
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:42:51 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CC4Pvk3320941
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eXn5lo8VTG6pz4itW10lS0zq+DfZaB5Zfbe/p13C0tE=; b=Yyw/drlUAXH+wwev
 zW2Ylz5V21QZPMlk3GIjUdafS7j4WM+uv2ylyVZdhyBF0uLzzXJZwlkRKZMgUce9
 jjYKA5Lwsyag9g+4dkVgq17eICrofwNQap+zknUWKZgXulKa+YGWE793FGmtOjpE
 IH5VuLWPVVm0cd3XjN8HxkgV9X/WEyn3zOO9mwzMNQWsVkdRqilqPoqnmgTjFeXd
 UGaOrzCers6WHnZfJY5b8hNHyRJnYEUzGOqad27uO8T9WrYucJCRuI50wAolfWYE
 1+npBp8818s7IuYjrcvTMVook3H2lttAxwNsnEe18//qGytwQCdDuSM4i9cYlkdT
 z3gXYw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43w1rtd0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:42:46 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1334825df27so1909428c88.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778600565; x=1779205365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eXn5lo8VTG6pz4itW10lS0zq+DfZaB5Zfbe/p13C0tE=;
 b=kNwm+DtAROuZqbXSYZUdwrB8YBliEFp7725QnSOPd+zoilP/kgZSyhc+BY2iRrwi1+
 JLwvI/YNn1iBap7UwikXoSQeFtkccx6NpWTQwGjS5ATIsLxdOsOpMWfSFnMn7yuvnF3s
 JtZICswEupFbHXuUeHpXL6IAl97XeacJDFOhc6Dy8EXzdxu1XIfk903tjS1Mrx6diVxg
 wXnjRS++AbTp8l7KPoOGI/O14wWkDGGK/ouH8eJQRnsOiI7cLGbbNI7/o5nsVlRnZg6f
 oaGl9p9LfQL6CYRfe7iwQ5RHW59Uzc3OPxYT83EpYIhoJTO3KNfwAS86gq9UwLE/mO3X
 LjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778600565; x=1779205365;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eXn5lo8VTG6pz4itW10lS0zq+DfZaB5Zfbe/p13C0tE=;
 b=sSaaE1QeZxuOwmraifcQz5nhJvWgxKrSiUv2zVJHKtfPChjvURcwYfcgB4312PkEUJ
 mXaNuQsRIXGa5y346Px9mxav9LRzWU9Ffke+Edaaekr/0ZI0+gSHVS417TXdoJpzY6VN
 TFUIdVyCz8fNMRJ02t419lSANHWSeUehF/cGTxeKCw2XQOPfhke5zWoGYZNCMjWPA3qB
 DaUEgm6r8+cVhR+AZRGgVTzNH5oN0DZJNmLdjlkA7duKe5XoYPYTf9Lez426T5m4YE6a
 PG6eyhBp3J01rDMUXliqJHqcPVdEhZk7PkQn5jG29zIDBk+ap3DWB8P8hh4iBrQkjj/9
 Dabg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9uu8j2FMhgbmSu0kcRpv06luH2mhHISZspipYJ4xl7SQmTWWyPCML0n4Awuy3Dm/ppbJBQCCJSEPR1@nongnu.org
X-Gm-Message-State: AOJu0Ywtm7thDV3sVqf2wUoJAko/i2atF6t57xS5xkbjSJT07hzZeaHe
 QABkSsSr3dzpYkvOFtqL65j9GD7hh+VA3XLFRArnMibPNMyu1/4tF3P5DDwxzpi7fRN9X87CV9R
 9htXNxWF9BSOBauQNVLL2twQS4SsSU5AczXTK6bCq4KA4mBnRYNKNejaffQ==
X-Gm-Gg: Acq92OHYVudMNee9I85p3Nf3ibKF5l3i1CrRXBcns84LjxmOmc+NOd81EI6p42WxTrq
 is35bdJcCEQb86DaroT0F2o5jG07+jGZeIjF9CRJBbQQgc+JrZaZzKifzjh61iowbL3YuMC3c5q
 GFu7GO6Wwnx5QiO491s4tMvk77D5SzFl/thIn+bxkoVMyZ3kI7m/m0ie2VgP5lR0iLcrpyJCx7j
 W1KYhBR5titfC60PzZMhFziCwHn58vRtwcIEBpo32K97FJrv6jkk3zscElQIX/42+d3U5356/B9
 5x4O39x6M2ThcBfEnNN3XQ8qFdxS1jlHGPK6GMqRHkvPAa1Ol4uttHsOeVmaBpAIARwRr73yver
 axmUF8OtxEMlZ6uTjKoERq/LX59k3QQYOBJkshQptdvRRFGIAOoGpKWW59r6nJd5XjklsmK7ka8
 NWXS9vP3Dfv10WjA==
X-Received: by 2002:a05:7023:b09:b0:130:6904:e81f with SMTP id
 a92af1059eb24-13344fa5719mr2088602c88.30.1778600565419; 
 Tue, 12 May 2026 08:42:45 -0700 (PDT)
X-Received: by 2002:a05:7023:b09:b0:130:6904:e81f with SMTP id
 a92af1059eb24-13344fa5719mr2088572c88.30.1778600564834; 
 Tue, 12 May 2026 08:42:44 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132787673ffsm24969545c88.15.2026.05.12.08.42.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:42:44 -0700 (PDT)
Message-ID: <e4ecb998-1940-4f54-afa6-fbe9c45d167c@oss.qualcomm.com>
Date: Tue, 12 May 2026 08:42:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] tests: remove redundant meson suite for iotests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-5-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424154205.364268-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4kmpOFx3ybiSpxXHIjY5g5MnnGmzg5B9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2MyBTYWx0ZWRfXyQxGEoRdbWzS
 WeT8AZu9ko9gkbWKTWgGgfo3gtNkHXCI6hvP7vnMloftQLOsFKQ5yuHWwxFKg6VFmYPnjVtRJUu
 LQr2w3k7OMIeG2nggPTuZhU8/SKDScMcaOhdSp9bsIeaafzxcjnewZdJTM3S05rYRzECWEbvEkk
 oFtKgvT0bfgXxiJBs91OZKNvyWA4dfxGm4fzL/mm3y3Z4809lMs7qjI3BW4NhB7gzTbZuNPDX7u
 ccZuao+GBlMSwEYUhQGxWAPAozcFE0wWv/UTAHD27rhGfNLPgPLjt/f56nwDLrRpvg7fuP82/ZN
 H+oOxwBQ1VmMReFqWyEUK18NXcy5sChWjiOW4zf3FLYAhtvLidBTNIdOR+0yr55OxlosjJfPZc/
 6FT1emTMCicZg3WZMLsgAsauU0w1etBjYR3p1vIGUx5wrSjTucwBNaJXB0uIBYqyCLC5vGpmwOR
 zTfFJk1urb3N7V1peug==
X-Proofpoint-ORIG-GUID: 4kmpOFx3ybiSpxXHIjY5g5MnnGmzg5B9
X-Authority-Analysis: v=2.4 cv=BoGtB4X5 c=1 sm=1 tr=0 ts=6a034a76 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=du9JezkGabr_sqfEBDUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120163
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/24/2026 8:41 AM, Daniel P. Berrangé wrote:
> If a test is in the 'block-slow' or 'block-thorough' suite, there is no
> need to also add it to the 'slow' or 'thorough' suites.
> 
> Tested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  tests/qemu-iotests/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

