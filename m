Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C06CCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 23:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHrKN-0006N9-KD; Fri, 16 Oct 2026 19:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrKC-0006MM-7n
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:26:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrKA-0001o4-Ir
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:26:55 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GNFewo2616479
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 32Mgega+mnm/RgL/nJ6jw+W+cGnBLsNPLpleryxj4Ys=; b=fj+pK2nhXaqApKTI
 vKHxdqOtUQ60XerzVN2R9XcbUqKVtgu1SEbVGdPAUmFZIhQ9ie8RjUSh9C1QOQ0r
 Ltow0pYdrA0LeTeFgEN8P3oL2hiya7vytcFqvSRmW88YesBsHSumx0X6P1a2ZbLF
 5IlNSeuEh0tkGZvsBiWvtHppvlpyjLfwhbyIkMSO3Wu5wNb3ydCKQrc91tGTcq97
 wcnIzt3hvMwv1zq2hEOct11FSJmVifcb/DslG/niFtNQZt+9XIJ174Gdtb4QZkZk
 l91XuqBgl8MMXOGKF5pLYiFEOs2Ou/3NIVW/NPgLW37jJTgTtS7C0xQhWVe8zR1Q
 eZZEpA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhur2qxn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:26:53 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139b62317d0so1278603c88.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792193212; x=1792798012; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=32Mgega+mnm/RgL/nJ6jw+W+cGnBLsNPLpleryxj4Ys=;
 b=ekBA+yME2thU5NAX2cGrogESTaJIJ+/PSX92MzONnUVB29MmjfXUCU+p18KUjltTrh
 tfpAU6TreRHzXiwXSwXwCzpVb0YVoCp2nAxBgc0crmpBHq4VZ+O6O5wGwPO7frMVUcw2
 R3cgWRnnv8ffMiizmo8udv90oc1WBJBu6XO7HBFTk7cZWtHPUkdHbqJmBbvoh9MwTVXt
 +qXmJOAytV9DnOYzFeXVkJHBl/+5rzFgKn1kw4tn13nqIRyDu0sl89Ce58cBVzcAsO6g
 HryeOUk5wS9D92uXkAohwrVkrmIt5jDfQwZQwCBD4HStC4qs6BOA9e7epuWnxhM66j+Q
 ZpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792193212; x=1792798012;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=32Mgega+mnm/RgL/nJ6jw+W+cGnBLsNPLpleryxj4Ys=;
 b=EcVQrNHg9Z2ZlBqwtnBpnfyiA1IX3//2TjjuxnozJ6eTVSfo0Q/OoNIDxudQELEYBn
 UMq2TzyvyFlLmfGhT3TKNwQO5eDEAdawkyRyz4xQKfT6AGtoQ+qHYV6u7u6jaH0N3LSu
 CroWQy0/Ne8oglKeBCrBWsFyyK0kIE7J0fcWoT/5tHN/26QunKoJkhclV45Q6lTurM8W
 1xMGMa7AaFvyWmQM7yIvX/SDRdj3UwqwP4ugJE8s2kU4ywP5vksQaOXAkxZrRbNxLgs2
 shw10TZj57sB11WYMDq99dahu6vfzyhuolEmgToXK2z8q1nyA9ja0zHcaIkdTo2jbwCA
 KM9Q==
X-Gm-Message-State: AFq9FYIwXNWB04Mbd8hW8k7PRawyqYd7Honp5tyLqAQQDw6CqdOqj51o
 6ElpHVZbFv5F3sx5LmBuJMB3IyFw1oxrQMKcFE8ddOC9sym//SxEf6E5Wfgs1psZ9eEoBjjgUPu
 0wQt+cirRY8dEvcvKXAgHggWrIkorkKeOC9gpZpZRGQNLwEzOvT6ZyjVBsCC9e4KKuA==
X-Gm-Gg: AYBFou0QYnAIEuETn3+LaxCgCQAFNQHO4KkGj/iRwRh492jR2c90JzQTzcnse/2Rkdo
 LToYEOu2KK+NWrPzpIJgJ/aR9Hby51ZGMDutyuQAi83SkszSvzK1E0hAbXUC7cBVnvQtxLW8E9k
 USjmfIO4NR1YGQBR6wCfWJjoAFsDcN/rToAirpHgKmyYLJejAId43yUwqKhevCPfAgP7kD3is2D
 i2a9W6EAyfkxQ5Fx+CFE+TZthGG41hJYjsMkVhZ6l7S3YJviWuZEh7WgWaw//V68lSM2VEtloxt
 D2wch1Xw42QRz3gPujHzu4Rn0YztFxLoUu5yMwPrphZ+dsMMxYsPFjK3pcCCJmc/OKJweJxMrqn
 kBnveYcRekghWW5bFygdsTIkMB+4GtzzFDsrnB0BykHpu7N8TRGedTs24yWUbAbWaWY+GTA==
X-Received: by 2002:a05:7022:3c0a:b0:14a:d8fe:33ae with SMTP id
 a92af1059eb24-18512f1c2b4mr1611044c88.24.1792193212227; 
 Fri, 16 Oct 2026 16:26:52 -0700 (PDT)
X-Received: by 2002:a05:7022:3c0a:b0:14a:d8fe:33ae with SMTP id
 a92af1059eb24-18512f1c2b4mr1611020c88.24.1792193211590; 
 Fri, 16 Oct 2026 16:26:51 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831c5cb39esm9041517c88.22.2026.10.16.16.26.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 16:26:51 -0700 (PDT)
Message-ID: <65c3cbf5-7494-4763-b437-f74b60c13baf@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 16:26:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] multi-target: add riscv64-softmmu
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfX72gi9XH6pS3T
 hzLYz7F1CrLAvvMJMZmbVxiDA779x4ANsf95ShqVPCIxAtBlldwkZgtv5iQSqEAGYQVVK3gSYpY
 utqn1zjZ8IftCiW7/5+P48/r0F11xxhUL6aO129GQoyjEXbRblU8sG9/ixZ4zmbFCL5+sP5NvcD
 ZsrMTb5RA60KFl90fdIk4OXqnymchPb8TfKV+aE8hKjJ+v77AVPWr1ZmWv7FWuK+4UsNkGkwpNG
 ItdJPiByFjypwfzQH25xPKCnasAR3t1kNUDtJ0z0m+7KKJTpsErV3OGhGiMr/Vi1ls/ZUBXg3nq
 NJrs03zhHB/Cm9wuyd+MEYuK5mVQzCUes+TE4FDY2NiSTJM6b/tptwuS8Ee0sc3njwzW/4A/4fP
 s5+rxjyXoS5CcRa5dDtf4Z5MOnBKoF4VmqP3gatIgO68dJDtli/hKxRkPHoDucFGvNRT5DRIooD
 JYvkr9dAkBzJzpVs00w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfXw6L65UtF69Qw
 9yIg8/3JgatW8uMeeBfVFVz4Icq1Kni5aL9Hw+ypnNlFCl0rL3saNGpZAVJAKw2w0J2eV28f452
 sgDUODk2/v5AcOZDg1cDTJz7HiJ6S48=
X-Authority-Analysis: v=2.4 cv=PqsG/AM3 c=1 sm=1 tr=0 ts=6ad2b2bd cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ItdST01KEd2itr_eys4A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: 4IrQW_AWjBRCRz5EClLD_LX2hhRiH8Lc
X-Proofpoint-GUID: 4IrQW_AWjBRCRz5EClLD_LX2hhRiH8Lc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160093
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

On 10/16/2026 11:27 AM, Pierrick Bouvier wrote:
> This series adds this target to set of multi-target.
> Changes are straightforward: functions and helpers renaming, and one type
> restriction for this target only.
> 
> While the series applies cleanly, it will need those additional two series to
> build multi-target test binary:
> 
> - Based-on: 20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com
> "multi-target: remove dump functions duplication"
> - Based-on: 20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com
> "multi-target: remove qmp_query_cpu_model_expansion duplication"
> 
> Usually I prefer to wait for series to be merged, but I have good hope to catch
> the freeze date if current series is reviewed, and send all three at once.
> 
> Pierrick Bouvier (6):
>   hw/riscv/virt: restrict scope of virt_is_acpi_enabled to this file
>   target/riscv: rename virt_acpi_setup to riscv_virt_acpi_setup
>   target/riscv: prefix helpers conflicting with other arch
>   target-info: add target_base_riscv
>   target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv targets
>   meson.build: add riscv64-softmmu to multi-target
> 
>  hw/riscv/virt-acpi-build.c                    |  2 +-
>  hw/riscv/virt.c                               | 12 +++++-----
>  include/hw/riscv/virt.h                       |  3 +--
>  include/qemu/target-info.h                    |  7 ++++++
>  meson.build                                   |  1 +
>  target-info.c                                 | 11 +++++++++
>  target/riscv/helper.h                         | 24 +++++++++----------
>  target/riscv/tcg/bitmanip_helper.c            |  4 ++--
>  target/riscv/tcg/fpu_helper.c                 | 16 ++++++-------
>  .../tcg/insn_trans/trans_privileged.c.inc     |  2 +-
>  target/riscv/tcg/insn_trans/trans_rvd.c.inc   |  8 +++----
>  target/riscv/tcg/insn_trans/trans_rvf.c.inc   |  8 +++----
>  target/riscv/tcg/insn_trans/trans_rvi.c.inc   |  4 ++--
>  .../tcg/insn_trans/trans_rvzicfiss.c.inc      |  2 +-
>  target/riscv/tcg/insn_trans/trans_xlrbr.c.inc |  4 ++--
>  target/riscv/tcg/op_helper.c                  |  4 ++--
>  target/riscv/tcg/tcg-cpu.c                    |  1 +
>  target/riscv/tcg/translate.c                  |  4 ++--
>  18 files changed, 68 insertions(+), 49 deletions(-)
> 

Sent v2, making sure riscv virt machine is only available for riscv
targets, and update multi target test to catch this:
https://lore.kernel.org/qemu-devel/20261016232304.1215119-2-pierrick.bouvier@oss.qualcomm.com/T/#

Regards,
Pierrick

