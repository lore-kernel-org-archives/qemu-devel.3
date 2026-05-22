Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793F6CD5BAC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 20:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQWKE-0003YL-Im; Fri, 22 May 2026 16:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQWKD-0003Y5-2h
 for qemu-devel@nongnu.org; Fri, 22 May 2026 16:18:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQWKA-0003EB-Oj
 for qemu-devel@nongnu.org; Fri, 22 May 2026 16:18:28 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MGamSM1733027
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 20:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=j6nZlpqB69/34i9rMoWSLGSU
 fZslzAVKMCXHd7Yeqtw=; b=FZ7xb2TYC6E4OBA7xItaJSC7ydjNYZZTBsBMBBQ9
 /xQTGU5Oh9H3hS9T+lvKhAUB5l2qtYwGh7fOOOq40NQ6DJOAnTzPDd3qwxNaxxy0
 AiMM2tqFZATEYO9Byd6LUhXtVOHxYmKo7Jqwe2gPxTGJz6Qxdohc7JYmKLQR1JBp
 cgfcIRCcIaBZ0zk/mSwTgM+w6clLIYb4pNWPuOdkEpuHPKBrOGFYYYp2K7hXVR0B
 MeOYObL57rz2uTWmddNLA/txpZ4ZDKTOlvfCTzixYEmL9CCP1Ntb6ZWp16Qpt1QJ
 GjuSEOsTTffFPOmBDosLsJ6JJjq2lKUu4FTxYRKQ55p5SA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eattq8s17-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 20:18:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304627c66ddso287100eec.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 13:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779481103; x=1780085903; darn=nongnu.org;
 h=in-reply-to:content-language:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6nZlpqB69/34i9rMoWSLGSUfZslzAVKMCXHd7Yeqtw=;
 b=h35h2du2yhtNGmpzUNZchmMpu42RG42AO6vM0bfhnY30CLIomzerGiEsFCB9TMgxy0
 ZymrEYC+vFP/Rq0w+9l9BDCwK1gDhdESRBshAYx7nWxRN7jrCJosK/Jp840SXESB1pq9
 Dn9+3HiX8B0CadCTm9c6gzc6xzNXYlZbtW+WUiKuLvmhBIhH7vba3JC0uYHqM0UUvPP8
 V/jh2wVsZi/xxT79MTvWM/SJnPG14HrTs49gA55dBSkl2Lcoh8BiWui+DJkDIbQmApgq
 zbiE0Xz62TPVM1Qk9GJ4wMDgfa+PbahmprIN5VdxYG4Itz0l12iLWeD+Hu/0UiVWApqd
 yB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779481103; x=1780085903;
 h=in-reply-to:content-language:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j6nZlpqB69/34i9rMoWSLGSUfZslzAVKMCXHd7Yeqtw=;
 b=bM+RNXHGw4Co6/GgTUsTdwQ1xARcXGOTZVH9eNvEk4DLHg4KMe80tMZsq2dzhwhjBF
 6UPlaRkUZ5HoMbIjyMc+Ztw2LyOquWNessbw2pL0VFltBshsCUJS+jYjFwqj40knb1bS
 /okDYEpyx/fbwL3PcAiORxeWxgDF1TGzdwUo6h1OymN+38fVCI5ixjX64YLpL2p6BJUr
 lZGQlNN0LUUCu/458vgVKZxIvZOBg4H0yL3Ur2AMChFZ7Tos5pgPTmwqUEa0QFvTSGoE
 7+ZS0wEW++tzFZUMyAjWXVkCdvrwOKs91U2xLKCenpSqVzBaUUeoINBNhCOsxE0u18Qy
 SfXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ870NNq3TFhGfZS0rohKCM2kYsIe+YVP2w7Jkd3ykJvUzAZD1Stpbl+bTkaZGx0SiIFBt8A4aZ2mWUm@nongnu.org
X-Gm-Message-State: AOJu0Yy4NgvFK5eXnd/r+MEhWnCtgtM1lsgyq/QZJR3+PSGJad87+k9b
 uR6Gq8GdD3sEKmr2xHHMiSRcAgdgFvHAk71DfmC9nNDihTMyA94iP6VteiaQrImC0NFTVw2gCAH
 v830p4f3HZcGWDIzqpC9lvznT1Cm3xDWztXn8BYlQduQA4UUCvRnq2waK9w==
X-Gm-Gg: Acq92OEQe3eXdsjbuj93P/Htx6XyR0eLRNfXktK6HrXfJwoaVtceS1b3HrTQmkeuqNt
 HzrS49Poi8USYbYQY8A9EO5r7b94PFEJwgWiI30s62VmfwLQ8daSkOR0Sz5vqBGn9Qvx1YV+iLz
 cLZ+5ZxRE3uZl4PNHCaFGtMed4rg/oFbC2jBVR6KtS3xiMYjnV/LIedg3+E05ABxKU3QuYYl+xS
 3YqShzY9qL7edUkfbQwRKZT4U8+ULJ/WlayA1HRDbFVUD2miGXnj7xVZfpotfBS/byemE1j4zxp
 9eoaLK5rEZvMgI4ZbV189eNY/hI98J2CPI79338q4g2PpOYAmEV1l5sW1my+nT55wR5PtEuzAN1
 JVLt5Sne1CIeBU1qgEz97IT2NmMuXHWL2ZEpAqyAZW21yshuGaXp4UcO8tb9pUzVOkT7ySxX2Qe
 UXuZMDaUT3jZBH5A==
X-Received: by 2002:a05:7022:6620:b0:12a:b39a:339f with SMTP id
 a92af1059eb24-1365fb58eedmr2025591c88.21.1779481102877; 
 Fri, 22 May 2026 13:18:22 -0700 (PDT)
X-Received: by 2002:a05:7022:6620:b0:12a:b39a:339f with SMTP id
 a92af1059eb24-1365fb58eedmr2025573c88.21.1779481102165; 
 Fri, 22 May 2026 13:18:22 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a4011d9sm1766587c88.6.2026.05.22.13.18.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 13:18:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------75X0iV80hhpv80fpnE0aap0p"
Message-ID: <d52c0fca-3a8a-4d4f-abff-f772605512b8@oss.qualcomm.com>
Date: Fri, 22 May 2026 13:18:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/39] MAINTAINERS: Fix F: lines
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20260521080511.999266-1-armbru@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260521080511.999266-1-armbru@redhat.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIwMiBTYWx0ZWRfX6dIDUp5rqg8U
 dGUiUB6fPmZNSBNq01wNq1oIEbJ0Nnvo0d4vFICkFqAdTcWlVG0KbkS6PndMaQ/kl3Ru/51qOgi
 aCQ5SYiyJV/luSvN8ToBilRQ/5CMENfH3Y7LREAQLWTc+BqKxRwrgbD7dZbaCVpIj3lEkKmh/dh
 f6yHY7WZTCBGvgn1nkWdfwzOo5gjusoMw0gNyKkDeFz5c3523PPFi+9OuUZI66tBqgo6emm0Pd4
 BySMS3DP9Tzad2OLksW3LkzPYVGTQmrbMohUXa+//dC9mscA0GStptd0jP43zbbPCgZcR038Axz
 dlm4MtX1zqrI0S8QEywGIc1xouCm7lg7OSMhXBhMlulv+mqCg2SAkYSmigFvvOeTMXEKhabwqaq
 o//K5cW+h20DQKeXtq/DQRUCNFpv7Pku7l3sie659lId7jgTsUl0EuNmdVJ8VDktWw5sieCX8vU
 g7wi4E5INOgsHLbWNWw==
X-Proofpoint-GUID: MoSTeTAbrHk8mxVm560e1NudJroF4ZP0
X-Proofpoint-ORIG-GUID: MoSTeTAbrHk8mxVm560e1NudJroF4ZP0
X-Authority-Analysis: v=2.4 cv=S/zpBosP c=1 sm=1 tr=0 ts=6a10ba10 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=ifkgRbV4gKzZCirtK20A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Ikd_lo372LEE3i8avE8A:9 a=B2y7HmGcmWMA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220202
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

This is a multi-part message in MIME format.
--------------75X0iV80hhpv80fpnE0aap0p
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Markus,

On 5/21/2026 1:04 AM, Markus Armbruster wrote:
> Quite a few F: lines don't match any files.  The quick & dirty check
> 
>     $ ls `sed -n 's/^F: *//p' MAINTAINERS ` >/dev/null
> 
> finds about fifty.
> 
> Philippe Mathieu-Daudé recently posted a few fixes:
> 
>   MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.docker path
>   MAINTAINERS: Cover debian-loongarch-cross.docker with LoongArch section
>   MAINTAINERS: Cover debian-xtensa-cross.docker with Xtensa section
>   MAINTAINERS: Cover debian-tricore-cross.docker with TriCore section
>   MAINTAINERS: Cover python.docker with Python library section
>   MAINTAINERS: Fix s390x storage key/attribute device paths
>   MAINTAINERS: Fix tcg/s390x/ path
>   MAINTAINERS: Correct scripts/coverity-model.c path
>   MAINTAINERS: Fix hexagon-linux-user.mak path
> 
> These are in
> 
>    Subject: [PATCH 0/7] docker: Remove LegacyKeyValueFormat warnings
>    Date: Mon, 18 May 2026 12:22:15 +0200
>    Message-ID: <20260518102222.80735-1-philmd@linaro.org>
> 
>    Subject: [PATCH v2 0/4] buildsys: Stop checking for ESA/390 host
>    Date: Tue, 19 May 2026 19:12:36 +0200
>    Message-ID: <20260519171240.97420-1-philmd@linaro.org>
> 
> 
>    Subject: [PATCH] MAINTAINERS: Correct scripts/coverity-model.c path
>    Date: Tue, 19 May 2026 19:19:26 +0200
>    Message-ID: <20260519171926.98099-1-philmd@linaro.org>
> 
>    Subject: [PATCH] MAINTAINERS: Fix hexagon-linux-user.mak path
>    Date: Wed, 20 May 2026 14:39:47 +0200
>    Message-ID: <20260520123947.12711-1-philmd@linaro.org>
> 
> This series takes care of the remainder, except for one discussed
> below.  It applies cleanly with and without Philippe's patches.
> 
> The exception is the last line in
> 
>     Python scripts
>     M: John Snow <jsnow@redhat.com>
>     M: Cleber Rosa <crosa@redhat.com>
>     S: Odd Fixes
>     F: scripts/*.py
>     F: tests/*.py
> 
> Both F: are actually wrong here: they match only in the scripts/ and
> tests/ not further down.  Left for another day.
> 
> Markus Armbruster (39):
>   MAINTAINERS: Improve another "Overall" section headline
>   MAINTAINERS: Delete trailing colons in section headlines
>   MAINTAINERS: Drop stale F: from "Guest CPU cores (TCG)"
>   MAINTAINERS: Drop stale F: in "RISC-V TCG CPUs"
>   MAINTAINERS: Drop stale F: in "SPARC TCG CPUs"
>   MAINTAINERS: Drop stale F: from "Overall KVM CPUs"
>   MAINTAINERS: Drop stale F: from "Overall CPUs other accelerators"
>   MAINTAINERS: Drop stale F: from "virtio"
>   MAINTAINERS: Fix F: in "Apple Silicon HVF CPUs"
>   MAINTAINERS: Drop bad F: in "X86 Xen CPUs"
>   MAINTAINERS: Fix F: in "WebAssembly"
>   MAINTAINERS: Fix F: in "Allwinner-a10"
>   MAINTAINERS: Fix F: in "Raspberry Pi"
>   MAINTAINERS: Drop bad F: from "Xilinx Zynq"
>   MAINTAINERS: Drop stale F: from "New World (mac99)"
>   MAINTAINERS: Drop stale F: from "sPAPR (pseries)"
>   MAINTAINERS: Fix F: typo in "sam460ex"
>   MAINTAINERS: Fix F: in "SiFive Machines"
>   MAINTAINERS: Fix F: typo in "ACPI/HEST/GHES/ARM processor CPER"
>   MAINTAINERS: Fix F: in "SSI"
>   MAINTAINERS: Fix F: in "vhost"
>   MAINTAINERS: Fix F: in "virtio-input"
>   MAINTAINERS: Fix bad / stale F: in "virtio-rng"
>   MAINTAINERS: Fix F: in "vhost-user-stubs"
>   MAINTAINERS: Fix F: in "virtio-snd" and "virtio-gpu"
>   MAINTAINERS: Fix F: typo in "pcf8574"
>   MAINTAINERS: Drop stale F: from "Block I/O path"
>   MAINTAINERS: Fix F: typo in "Dump"
>   MAINTAINERS: Drop stale F: from "Human Monitor (HMP)"
>   MAINTAINERS: Fix F: in "QDev"
>   MAINTAINERS: Fix F: in "QMP"
>   MAINTAINERS: Fix F: typo in "I3C"
>   MAINTAINERS: Drop stale F: from "EDK2 Firmware"
>   MAINTAINERS: Drop stale F: from "TCI TCG target"
>   MAINTAINERS: Drop stale F: from "Linux io_uring"
>   MAINTAINERS: Fix F: in "VFIO-USER"
>   MAINTAINERS: Fix F: in "Build and test automation"
>   MAINTAINERS: Drop stale F: from "Sphinx documentation configuration
>     ..."
>   MAINTAINERS: Fix F: in "Rust build system integration"
> 
>  MAINTAINERS | 73 ++++++++++++++++++-----------------------------------
>  1 file changed, 24 insertions(+), 49 deletions(-)
> 

thanks for posting this.

In addition, see the patch attached to this email.
It integrates checking this directly at configure time, so we never run
into any missing entry again in the future.

I share this here not for a review, but simply to avoid a duplicated
effort, and make sure people know it will be sent after this series.

I don't believe in adding this in checkpatch, because it's not enforced
systematically unfortunately. Breaking the meson configuration is a good
way to make sure it's enforced by design.

With your series applied, the left entries are:
No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +258:
configs/targets/hexagon-linux-user/default.mak
No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +259:
docker/dockerfiles/debian-hexagon-cross.docker
No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +2956:
hw/s390x/storage-keys.h
No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +2965:
hw/s390x/storage-attributes.h
No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +3241:
scripts/coverity-model.c
No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +3468:
tests/*.py
No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +4149:
tcg/s390/

Once your current series is pulled, I'll fix the remaining and send the
attached patch. Or feel free to do it directly if you like the idea :)

Regards,
Pierrick
--------------75X0iV80hhpv80fpnE0aap0p
Content-Type: text/plain; charset=UTF-8;
 name="0001-meson.build-check-MAINTAINERS-file-is-consistent-wit.patch"
Content-Disposition: attachment;
 filename*0="0001-meson.build-check-MAINTAINERS-file-is-consistent-wit.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2YzliNDlhYzdlYzA2YzAxNTlkMmI0YmE5YzlkMTA4MWUwMmVmNzY1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQG9zcy5xdWFsY29tbS5jb20+CkRhdGU6IEZyaSwgMjIgTWF5IDIwMjYgMTI6MjM6MTcg
LTA3MDAKU3ViamVjdDogW1BBVENIXSBtZXNvbi5idWlsZDogY2hlY2sgTUFJTlRBSU5FUlMg
ZmlsZSBpcyBjb25zaXN0ZW50IHdpdGggc291cmNlCiB0cmVlCgpXZSBhZGQgYSBuZXcgc2Ny
aXB0OiBzY3JpcHRzL2NoZWNrLW1haW50YWluZXJzLWZpbGUucHksIHRoYXQgd2lsbCBydW4g
YXQKY29uZmlndXJhdGlvbiB0aW1lIChhbmQgbm90IGF0IGJ1aWxkIHRpbWUpLCB0byBub3Qg
aHVydCBidWlsZCB0aW1lLgpUaGlzIHNjcmlwdCBydW5zIGluIDAuMnMgb24gbXkgZGV2IFZN
LCB3aGljaCBoYXMgYW4gb2xkIGNwdS4KCldlIGNhbiBleHBlY3QgdGhpbmdzIHRvIGJlIG1v
c3RseSBpbiBzeW5jIHNpbmNlIGFkZGluZyBvciByZW1vdmluZyBhCnNvdXJjZSBvciB0ZXN0
IGZpbGUgd2lsbCB0cmlnZ2VyIGEgY29uZmlndXJlIHN0ZXAuCkZvciB0aGUgcmVzdCwgbGlr
ZSBkb2NzLCB0Y2cgdGVzdHMsIG9yIHJlbWFpbmluZyBmaWxlcywgR2l0TGFiIENJIHdpbGwK
YnVpbGQgdGhpbmdzIGZyb20gc2NyYXRjaCBhbmQgYWx3YXlzIHJ1biB0aGUgY29uZmlndXJl
IHN0ZXAuCgpXaXRoIHRoaXMsIGl0IHNob3VsZCBiZSBpbXBvc3NpYmxlIGJ5IGRlc2lnbiB0
byBoYXZlIGFuIHVwc3RyZWFtCk1BSU5UQUlORVJTIGZpbGUgd2l0aCBub24gZXhpc3Rpbmcg
ZmlsZSBlbnRyaWVzLgoKU2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJp
Y2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgotLS0KIG1lc29uLmJ1aWxkICAgICAgICAg
ICAgICAgICAgICAgICB8ICA1ICsrKwogc2NyaXB0cy9jaGVjay1tYWludGFpbmVycy1maWxl
LnB5IHwgNTMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFu
Z2VkLCA1OCBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA3NTUgc2NyaXB0cy9jaGVj
ay1tYWludGFpbmVycy1maWxlLnB5CgpkaWZmIC0tZ2l0IGEvbWVzb24uYnVpbGQgYi9tZXNv
bi5idWlsZAppbmRleCBlZWIwOTZjMTQ4Ny4uZGRmYjBiOTBjYTYgMTAwNjQ0Ci0tLSBhL21l
c29uLmJ1aWxkCisrKyBiL21lc29uLmJ1aWxkCkBAIC0xOCw2ICsxOCwxMSBAQCBhZGRfdGVz
dF9zZXR1cCgndGhvcm91Z2gnLAogCiBtZXNvbi5hZGRfcG9zdGNvbmZfc2NyaXB0KGZpbmRf
cHJvZ3JhbSgnc2NyaXB0cy9zeW1saW5rLWluc3RhbGwtdHJlZS5weScpKQogCisjIGNoZWNr
IG91ciBNQUlOVEFJTkVSUyBmaWxlIGlzIGNvbnNpc3RlbnQKK2NoZWNrX21haW50YWluZXJz
ID0gZmluZF9wcm9ncmFtKCdzY3JpcHRzL2NoZWNrLW1haW50YWluZXJzLWZpbGUucHknKQor
bWFpbnRhaW5lcnNfZmlsZSA9IGZpbGVzKCdNQUlOVEFJTkVSUycpCitydW5fY29tbWFuZChb
Y2hlY2tfbWFpbnRhaW5lcnMsIG1haW50YWluZXJzX2ZpbGVdLCBjaGVjazogdHJ1ZSwgY29u
c29sZTogdHJ1ZSkKKwogIyMjIyMjIyMjIyMjIyMjIyMjIyMKICMgR2xvYmFsIHZhcmlhYmxl
cyAjCiAjIyMjIyMjIyMjIyMjIyMjIyMjIwpkaWZmIC0tZ2l0IGEvc2NyaXB0cy9jaGVjay1t
YWludGFpbmVycy1maWxlLnB5IGIvc2NyaXB0cy9jaGVjay1tYWludGFpbmVycy1maWxlLnB5
Cm5ldyBmaWxlIG1vZGUgMTAwNzU1CmluZGV4IDAwMDAwMDAwMDAwLi5iMDAxODE2YTQwMQot
LS0gL2Rldi9udWxsCisrKyBiL3NjcmlwdHMvY2hlY2stbWFpbnRhaW5lcnMtZmlsZS5weQpA
QCAtMCwwICsxLDUzIEBACisjISAvdXNyL2Jpbi9lbnYgcHl0aG9uMworCisjIENoZWNrIGlu
Y29ycmVjdCBmaWxlIGVudHJpZXMgaW4gTUFJTlRBSU5FUlMKKyMKKyMgQXV0aG9yOiBQaWVy
cmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+CisjCisj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisKK2ltcG9ydCBh
cmdwYXJzZQoraW1wb3J0IGdsb2IKK2ltcG9ydCBzeXMKKworCitkZWYgY2hlY2tfb25lX2Vu
dHJ5KGxpbmUpIC0+IGJvb2w6CisgICAgcmV0dXJuIFRydWUKKworCitkZWYgbWFpbigpIC0+
IE5vbmU6CisgICAgcGFyc2VyID0gYXJncGFyc2UuQXJndW1lbnRQYXJzZXIoZGVzY3JpcHRp
b249IkNoZWNrIE1BSU5UQUlORVJTIGZpbGUiKQorICAgIHBhcnNlci5hZGRfYXJndW1lbnQo
Im1haW50YWluZXJzIiwgaGVscD0iUGF0aCB0byBNQUlOVEFJTkVSUyBmaWxlIikKKyAgICBh
cmdzID0gcGFyc2VyLnBhcnNlX2FyZ3MoKQorCisgICAgZm91bmRfZmlsZV9lbnRyeSA9IEZh
bHNlCisgICAgZm91bmRfaW5jb3JyZWN0X2VudHJpZXMgPSBGYWxzZQorICAgIGxpbmVfY291
bnRlciA9IDAKKworICAgIHdpdGggb3BlbihhcmdzLm1haW50YWluZXJzKSBhcyBmaWxlOgor
ICAgICAgICBmb3IgZW50cnkgaW4gZmlsZToKKyAgICAgICAgICAgIGxpbmVfY291bnRlciAr
PSAxCisKKyAgICAgICAgICAgIGlmIG5vdCBlbnRyeS5zdGFydHN3aXRoKCJGOiIpOgorICAg
ICAgICAgICAgICAgIGNvbnRpbnVlCisgICAgICAgICAgICBlbnRyeSA9IGVudHJ5WzI6XS5z
dHJpcCgpCisgICAgICAgICAgICBmb3VuZF9maWxlX2VudHJ5ID0gVHJ1ZQorCisgICAgICAg
ICAgICBmaWxlX2V4aXN0cyA9IGxlbihnbG9iLmdsb2IoZW50cnksIHJlY3Vyc2l2ZT1UcnVl
KSkgPiAwCisgICAgICAgICAgICBpZiBmaWxlX2V4aXN0czoKKyAgICAgICAgICAgICAgICBj
b250aW51ZQorCisgICAgICAgICAgICBmb3VuZF9pbmNvcnJlY3RfZW50cmllcyA9IFRydWUK
KyAgICAgICAgICAgIHByaW50KAorICAgICAgICAgICAgICAgIGYiTm8gbWF0Y2hpbmcgZmls
ZXMgZm9yIHthcmdzLm1haW50YWluZXJzfSAre2xpbmVfY291bnRlcn06IHtlbnRyeX0iLAor
ICAgICAgICAgICAgICAgIGZpbGU9c3lzLnN0ZGVyciwKKyAgICAgICAgICAgICkKKworICAg
IGlmIG5vdCBmb3VuZF9maWxlX2VudHJ5OgorICAgICAgICByYWlzZSBFeGNlcHRpb24oIm5v
IGZpbGUgZW50cnkgZm91bmQgLSBpcyBNQUlOVEFJTkVSUyBwYXRoIGNvcnJlY3Q/IikKKyAg
ICBpZiBmb3VuZF9pbmNvcnJlY3RfZW50cmllczoKKyAgICAgICAgcmFpc2UgRXhjZXB0aW9u
KGYiaW5jb3JyZWN0IGVudHJpZXMgZm91bmQgaW4ge2FyZ3MubWFpbnRhaW5lcnN9IikKKwor
CitpZiBfX25hbWVfXyA9PSAiX19tYWluX18iOgorICAgIG1haW4oKQotLSAKMi40My4wCgo=


--------------75X0iV80hhpv80fpnE0aap0p--

