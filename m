Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A064CA5FDD
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 21:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCO23-0005bN-IV; Thu, 01 Oct 2026 17:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCO21-0005b2-Mk
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 17:09:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCO1z-0004ml-JQ
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 17:09:33 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691IxH4g3522815
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 21:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RuOvK9AsXV+vsaaB3ahj1ODvTS/i+/mqr0dwoZF5bnw=; b=VQbkfIblsEUK+g3d
 rii/9RjJd3uAN//ahAWngqpeCK/0q/ghlXlc6UKL3Wvsbjpg6YNDWWReA1OmfUOZ
 UTAXGrYxLIrhQSYX2o6vXwUqjxFZxv4wm3m3iGxEbgsRqms9NU1jQp1+nm2PClCF
 l/SOEFkh8GMs12juBaVXQ/gG7MrdP+UqRNsD7QClXTQ2F4jRlYNUOLY3JqdKxpG4
 VX6u2LeHiLyKT3h55tGbVpnWT8+hcXT+2ZMPMCOay2k1FZRff9MXaFtJFG8c18fD
 ELALmgtRnIrnm+niJTvuReU/44n5LQLplEBJgW/aMRA24VDbLRq6Av96g4mI/SlS
 c4gP6g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1w8tgdyv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 21:09:29 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1466ab2bc8dso9685822c88.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 14:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790888968; x=1791493768; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RuOvK9AsXV+vsaaB3ahj1ODvTS/i+/mqr0dwoZF5bnw=;
 b=Mm7zYgZgMKBvCBQimXqxrCfRHT0J6cOH+Ystka2AdjDQ2Yfa0znfLJpEddIZL/oH1V
 i3YGTDu+PcaAiEjuVMNBx/1X03G27N+CYSm3TkTTOJJ7Uhsw2bd3g6rhAvo/mtm4uE1V
 3wf7Sfxfkun7eFxQaUFSvata6+sE+/Irq6RjceSBAJpydJFjLLodZwJfBWTHeSsoNe9t
 XdyNqUD4cFpDtqXtA1fLza6uvuf9ANXrSe/N+vJ+23pIkBM3XL71AImH+vM//g8ras4k
 54A9ILa3t2aPnEcLrDrggfZVACg/4bs0hg99AmmaiiAD+ZZ0pPDdYCPnpHSspDk2Jpjd
 Oibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790888968; x=1791493768;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RuOvK9AsXV+vsaaB3ahj1ODvTS/i+/mqr0dwoZF5bnw=;
 b=Mz/92kBpEnikf6vLNkFbU46CX1NifV7hB+BWJu2jG9f+4cy4zhjmPIn1GkLNd9iter
 LKF+Vahsfr7hkT91dii1otHL+P1iV5Aw6xg6eo+Gi+DY41k8mMaZFqhwXM7aqJuepo75
 FUCZ/m7TrjETbVjGs2S1hVpiioJ6Lq8+It7fWjQe9UJSAyl+W5wOruIAwkdkje6dBMPd
 EOFPcPHayRqWd3qMzY7xoo9L0bfnuzlvcxxDp6vjfLldh4V27cAQlucgN0kgkS9zdfGd
 oQFPMmS3aePl8rNtoC4YTIwgN2+hirtXRc8nb3DOzHMzx3uitIWOvKiQGVOArp3VCabX
 EqZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEAzf1DQlK90JKktjk8r18DAvzZxca1RHfBTaTv+Mh3sLa+YKQ7tLuu2Kh6NYKo6XyOiZcd7Lgb+0F@nongnu.org
X-Gm-Message-State: AFuF++n1n0og+5IdOVfNMbHl4aQzQZ2LanaVxdfn5R9oWapLACc52xqt
 AornzcKK2lRkPE5ZSv80NYoFw2ecUtMt1gQVMpwH4Ym0kp0u8VL2VcX8rMzzXo/Lhe3m1gNkmJ4
 J8vzRzE27hPnio1A40RPdtBCD+K0WjMV25vpbzkf5V17iwf3NiXhA1r7/7g==
X-Gm-Gg: AYBFou0CTdagIHHy6y899uZwTlx9qQm0s/oHyfGF+Ciz01vDh1Rpff+TIlf/eJjNEoe
 t/Pi5i17BlFwbDigCJ7cTtWHk8t7azXQ3kTn1xsIs2VqoR+8UfZUfGNJAB1c5D39m1oo7k3jdMh
 WwGkEfsA6aZJlCX0TW2m9MoYSWcACHB5IysrnzdQrCcTjELR7caScBMWuGZFvHdqVTOQVc2CLZl
 vXn11jsVUTniehLE0m2hphnB5Unt8QrqlCALxQnr2CWdFwRW6GHhvvAdQHKpFuRqk3qUF9X+1Gc
 Luv78YLqy7WZe1FPJzwbV+d4/5HPPrCcSReFlM98kYlL+WVkeyE9TswU7VEMct2mDuE/pLUAAYn
 cWPVP+P0QW8u8SObiScfI0zeAmFs8ib5P1IRvpgiKBdLDDszT/42wChAMTbEEWjNr7JoDxA==
X-Received: by 2002:a05:7022:7e8c:b0:144:ed18:47ab with SMTP id
 a92af1059eb24-14f5b311ec1mr624723c88.13.1790888968357; 
 Thu, 01 Oct 2026 14:09:28 -0700 (PDT)
X-Received: by 2002:a05:7022:7e8c:b0:144:ed18:47ab with SMTP id
 a92af1059eb24-14f5b311ec1mr624678c88.13.1790888967725; 
 Thu, 01 Oct 2026 14:09:27 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f4718b21dsm979342c88.12.2026.10.01.14.09.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 14:09:27 -0700 (PDT)
Message-ID: <1e6da34b-d5a5-4d64-9a14-7e0ec5511cd0@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 14:09:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: fix register handle encoding to reserve NULL as
 invalid
To: yzhou <shuodedaoli6657@163.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-stable@nongnu.org
References: <179084344002.1109.17545828550697879192@163.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <179084344002.1109.17545828550697879192@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: z3FPEGs4Esa4gJpjY6CljxWsfZpvkftC
X-Authority-Analysis: v=2.4 cv=ML/1C8Zl c=1 sm=1 tr=0 ts=6abecc09 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=69wJf7TsAAAA:8 a=Byx-y9mGAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=dGsWvjqBAAAA:8 a=YiP96_SIJqGSjmxYw9wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=EwAE0RQWx3bH85eTCWcH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4NCBTYWx0ZWRfXyOjXSXvVOUux
 nw69HjlB0vBuMKfXwGptm9Er5+55cZZ3/z9YUcd/xtMwCOqT72fM7WV68wP3XAQlDHIy4cv4iip
 WLEVVp+8O/l3U77uZ4pheH+pTsjG2Yyts29PPET3QZ7kEAJ4nRygJuy7TJYVEc4mD8hjOzLYIp0
 tpD6FHVw9MDurmLfk7hfn4vaxg/1qPPGUfNSK0I3f8kqPFMY7Q/gkBtRn/JfaYLTC98bOoDgnYV
 O14/vgu6TxGTlK9+WwOJkIY/QIbETQyplThtRqeiScUpYv/KUZw5LJ4TJ8chCnGeT76WArzFlxr
 pILAzq8CDK7jP4d3hYW1mccYpl9A56zCE385zPtM7r4RyYTME58TIOGeUgIFfjZUY4VhS3uCDZC
 /5yvsDc88mdDWUZ999oO4fDDSBcWiIy+c+Bj9f8BvG5B/AhWIy1tBqosOrXiEIv2DMnJulKM7zG
 LzZvlYZmI7mSh7QTsNQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4NCBTYWx0ZWRfX+OhpF498OKKH
 O1/Nmf4xP5Qmj7Cd3PIzsFCuLlc9TQI3aLrHqc1nJ4/TwOyZO9R/zGw3UL4+OGeH3ZX2UGmMd7l
 nd2uA9FL81U93lhpzzGJzmFqkWA5p88=
X-Proofpoint-ORIG-GUID: z3FPEGs4Esa4gJpjY6CljxWsfZpvkftC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010084
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

Hi,

for some reason, this was not correctly sent on the mailing list, it's
not visible on https://lore.kernel.org/qemu-devel/, and thus not tested
on my side.

Could you please check git-publish, and resend it with this tool
instead? This will do the right thing.
https://github.com/stefanha/git-publish

Also, check if you're registered on the mailing list, else I think your
email is skipped: https://lists.nongnu.org/mailman/listinfo/qemu-devel

In case you're stuck, let me know, I'll resend it for you.

Regards,
Pierrick

On 10/1/2026 1:30 AM, yzhou wrote:
> The opaque register handles returned by qemu_plugin_get_registers()
> are currently encoded as:
> 
>     handle = (gdb_reg << 1) | read_only_bit
> 
> For the first core register of every target -- gdb_reg 0, not
> read-only -- this encodes to GINT_TO_POINTER(0), i.e. NULL. That is
> x86_64 "rax", aarch64 "x0" and ppc "r0", among others.
> 
> A NULL handle is indistinguishable from an invalid one, so any plugin
> that defensively checks its handles silently loses access to the
> first core register (where the Linux syscall number lives on x86_64,
> for example). Passing NULL to qemu_plugin_write_register() instead of
> being rejected silently writes register 0.
> 
> Restore the invariant that NULL is never a valid handle by keeping an
> offset on the gdb register number, as was already done before the
> read-only property was packed into the handle (see v10.0.0, where
> handles were encoded as GINT_TO_POINTER(gdb_reg + 1)):
> 
>     handle = ((gdb_reg + 1) << 1) | read_only_bit
> 
> Also assert in tests/tcg/plugins/registers.c that every descriptor
> carries a non-NULL handle: the current test passes the handles
> straight to read/write without checking them, and a handle encoding
> that maps a valid register to NULL goes unnoticed for that reason.
> 
> Found while writing a system-mode syscall tracing plugin, which could
> read neither the syscall number on x86_64 nor the first argument on
> aarch64 (both handles came back NULL).
> 
> Fixes: 55327b85ce32c ("plugins: prohibit writing to read-only registers")
> AI-used-for: code (prototype), tests (draft)
> Signed-off-by: yzhou <shuodedaoli6657@163.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Cc: Alexandre Iooss <erdnaxe@crans.org>
> Cc: qemu-stable@nongnu.org
> ---
>  plugins/api.c                 | 6 +++---
>  tests/tcg/plugins/registers.c | 8 ++++++++
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/plugins/api.c b/plugins/api.c
> index 3520c96..950d801 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -455,7 +455,7 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
>              desc.is_readonly = true;
>              plugin_ro_bit = 1;
>          }
> -        desc.handle = GINT_TO_POINTER((grd->gdb_reg << 1) | plugin_ro_bit);
> +        desc.handle = GINT_TO_POINTER(((grd->gdb_reg + 1) << 1) | plugin_ro_bit);
>          desc.feature = g_intern_string(grd->feature_name);
>          g_array_append_val(find_data, desc);
>      }
> @@ -480,7 +480,7 @@ bool qemu_plugin_read_register(struct qemu_plugin_register *reg,
>          return false;
>      }
>  
> -    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) >> 1) > 0);
> +    return (gdb_read_register(current_cpu, buf, (GPOINTER_TO_INT(reg) >> 1) - 1) > 0);
>  }
>  
>  bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
> @@ -497,7 +497,7 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
>          return false;
>      }
>  
> -    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) >> 1) > 0);
> +    return (gdb_write_register(current_cpu, buf->data, (GPOINTER_TO_INT(reg) >> 1) - 1) > 0);
>  }
>  
>  void qemu_plugin_set_pc(uint64_t vaddr)
> diff --git a/tests/tcg/plugins/registers.c b/tests/tcg/plugins/registers.c
> index 0e41734..02058fe 100644
> --- a/tests/tcg/plugins/registers.c
> +++ b/tests/tcg/plugins/registers.c
> @@ -29,6 +29,14 @@ static void vcpu_init_cb(unsigned int vcpu_index, void *userdata)
>      qemu_plugin_reg_descriptor *reg_desc = NULL;
>      bool success = false;
>  
> +    /* NULL must never be a valid register handle */
> +    for (size_t i = 0; i < regs->len; i++) {
> +        qemu_plugin_reg_descriptor *desc =
> +            &g_array_index(regs, qemu_plugin_reg_descriptor, i);
> +
> +        g_assert(desc->handle != NULL);
> +    }
> +
>      /* Make sure we can read and write a register not marked as readonly */
>      for (size_t i = 0; i < regs->len; i++) {
>          reg_desc = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
> 


