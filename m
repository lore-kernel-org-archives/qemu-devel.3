Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4CB606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G7371xkR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NTUCmI32
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLDny-0000WL-9j; Mon, 26 Oct 2026 02:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLDnu-0000Ve-Kk
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 02:03:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLDns-0003dC-NA
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 02:03:30 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4b4xn1340479
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 06:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M0ZmqMDn9YzKDjS+NauaKK3bpVFNtc5ZleCw/0q6nvY=; b=G7371xkRCiH5LqT2
 yA5EkDweQLFtXjOMEJ8o0z607TYmEmJXf8PHgUJfzuQJuRvTFpn11dOMBICvRgNl
 5ZlzDEkScv5a+jCu230nVRTroPBpJQsHXj8lVzJimg8mbvuunxDxyPP26HD8dT9m
 R1BRaq/vwHnZYZnV3tEvxMHjmJDB7Nuncvm0yNhg6e9OyZMy+kq6+YqpaD4aQ85M
 Kfilz8DsOApn47rZJe5vcpUV7L7dt7fPUpy7BILcVPdAHzLL0wRT2aMXKEz+lIil
 7Y3o3JukownHwMJBWP6aaACKR1zKZ5QfZIMkRG2vUZJq6bUuk6ifE1R2ftmRoiQz
 mbDtLw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgny9vu3v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 06:03:25 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f568dee56so368689485a.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 23:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792994604; x=1793599404; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=M0ZmqMDn9YzKDjS+NauaKK3bpVFNtc5ZleCw/0q6nvY=;
 b=NTUCmI326F5kCHxoCBKI5ydjMwq9XqR3WkCEvZc265TF4q4OqadOzR+Mn8oBRSCnte
 MazwDue3Xwzcw0CwpzYmpo/E4DFwPgUkvjCTx+BMJUjgHJ/rmhujURGEGgbrr7le1+ko
 W1GXWMm0dEfGHX3HPTuvfVJy6GzVN+b7qFfnWxeuOsiKrB1ibQgWIU2x36NpbSKh8YWt
 PhmsGHbQ9XVR8LEWRbHLncHqiNUXIXh9sOxZjU2maPPgFhohgV0V+UE5DzE7zXtOrjf0
 b7hnxWORASqO14NTzN52adWhlsABnxTWAh2dPw+cOoi/x2wFuTVxBD+L26YFqrwG3yzR
 Zrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792994604; x=1793599404;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M0ZmqMDn9YzKDjS+NauaKK3bpVFNtc5ZleCw/0q6nvY=;
 b=O0BlzzV7I2pX/KpzDRrk7fyy1NdvJLoxt7shH4YnaeO/aa0qfMTOXIqbCK8TzVFA3K
 lP0YThZDLK8V8bxXDOPm3zP7fXBsFig621gvOrxqdp7eoUhRdY0+2U1Yx35pwpgINAm/
 4XzOgi8xXut2sAXGsZv7VULQ7WEk7JRTP7qMsvJzsOazGsNsAKvbpowpK+nA1ldrIrhl
 PvWfJFr9EUtV0sPIsL1wLmT3liuLl3rapgdQtXPyuC3eXUb3KAMFQGZfs/hnNSOttog3
 OsZuLukgVI+XTb706ubycZAiBEdmsDAB/M1HEKHBw68rB21DUkLebZhpMaR0zb4TmHEk
 7IOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVg70yMS3CpH+TPaR6tHhFgEgGxI/coE8dyAIB7NlmNAvnFKPGjcjYF1j/0DaTTxQv3SVtf5Al1lLF@nongnu.org
X-Gm-Message-State: AFq9FYJKI4aC5ErOIzrVsB4NQj+NTAwXEsnLa0lKak4vmF61lx8N2PAd
 4Cd9/Oda0tIcRf+zWJcSpcj+/KlS+iJEcUHiIxZxsJswaTaTvnrZk0HOiY9carS7Y//lmg4tTLF
 vMokCXl1GzEoY3CtNu3S0AdVamHOH6hSrezBDmHA+ws7HVOl0VSzCw6CFlA==
X-Gm-Gg: AYBFou29RrFc0WDlFrrTM+4EyuQPsp1C6Wr7iRfPr+fSNwQ4lZ7bfZUKK9+S0DWfBTg
 Ps1VyECWeFIAgMr1G0nMrQfNPxazpsnvCIuvrtNoP9lapCkm19aEC0Z14u0ikFZNQu51EiPf3Hu
 ZVx1jigDfkKwzE9FqeyO3XS0Sy/1NpIw3UGj4cO3gxhQrc4B/f/1KAI+MgLC15nWS80XIpl9Sgr
 IWsnNJfUJZQTby11TVT+xNZhDteD2WACsIg4kk2HVXgqPGNtnEsl5BGPid/xrdnUbNJ9ApQNcrX
 nT9d6DywZPLAMrFP5wx3h6+y6pv61Biop9bfVMz7gKRlskCg14JLjAq2LvA8eyEg1lM1rqPvSy2
 mB9TAXlflDsF5yMvZbxyYM235amKy6nyg+A==
X-Received: by 2002:a05:620a:3726:b0:93c:c96c:a592 with SMTP id
 af79cd13be357-940ef8dab65mr873482985a.36.1792994604273; 
 Sun, 25 Oct 2026 23:03:24 -0700 (PDT)
X-Received: by 2002:a05:620a:3726:b0:93c:c96c:a592 with SMTP id
 af79cd13be357-940ef8dab65mr873480485a.36.1792994603747; 
 Sun, 25 Oct 2026 23:03:23 -0700 (PDT)
Received: from [192.168.69.230] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2ed5a2sm180032185e9.15.2026.10.25.23.03.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2026 23:03:22 -0700 (PDT)
Message-ID: <f54905bf-8641-4554-ac44-6d526266876c@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 07:03:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/block/pflash: invalidate TBs on flash update
Content-Language: en-US
To: Elliot Berman <elliotjb+anduril@elliotjb.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261016-pflash-update-invalidate-tbs-v1-1-3cf1ecaa76bc@elliotjb.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016-pflash-update-invalidate-tbs-v1-1-3cf1ecaa76bc@elliotjb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 38qrLXMlB2D9e66JNUYEfhiXokWP4Qgb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyMyBTYWx0ZWRfX84MXC0LEy93v
 b5MP+bBQ43Rtyl5haCWwD3Qq1skAxyBzxnm928J3/LxL9YgMP6a3xf7D77SiRr/lP7Ctr1mEBg9
 h2Mj7/UF/LRDmZr4KR/opJdzEdgDqHbhHqIaLUN4VkG9L4k38mr9oqj5UWgXLxuJTA8tUB112Kl
 cwFPcH+DXmuBAnq9kMAWi+OdAU+12RddEevZVmR+JfgCB+e3JGYVItY5vBuK+y9t5+84oWPZpm1
 LFICKwPaR1ar2fWR1mdxHvRuSJ5xEoIExuRik30MTuAtNH0wf+vjr6XZFJwTYLRdz+eL6/Y/eMH
 I+Vhp7MD0EBvDCVyqt77lTsODQurQBIpMiLmSAnDizm3lAQy6qw/njHsz1lVH9FBBiGjTyMr4D7
 c0eXuK4n9NWCDgHtDuKNlsZQB8eRdsRCWFypruupZO7zLcSknPshg1GuHb5poYVxQS25iwUzu7r
 dPbWup27enN7z86O+8w==
X-Authority-Analysis: v=2.4 cv=PqcG/AM3 c=1 sm=1 tr=0 ts=6adeed2d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=-LS97c69AAAA:8 a=e6dUo2my1cAMVXLlDhYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22 a=m2i-bEnOsJtWz63_nIdQ:22
X-Proofpoint-ORIG-GUID: 38qrLXMlB2D9e66JNUYEfhiXokWP4Qgb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyMyBTYWx0ZWRfX/pML7ceGCo6M
 wB0le1sj7XcRQuQ1x83fLOmdE7nApPtiEyntM/Jof09q5C9yqDU/MBVLGcVzAXkBXJFjeDndMNB
 fe0xW/d6xBy9FMaW+T7wiZ5dL6XOu+o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260023
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Elliot,

On 16/10/26 21:15, Elliot Berman wrote:
> When pflash_cfi01/02 are out of Read Array mode and being reprogrammed
> or erased (such as a firmware update) by a guest under TCG, TBs from
> when the guest was executing instructions from the pflash are never
> invalidated. After re-enabling Read Array, the guest continues to
> execute instructions from the stale TBs.
> 
> Call memory_region_flush_rom_device() from pflash_update() so the TBs
> over the updated range are invalidated.
> 
> memory_region_flush_rom_device() asserted that the memory region was in
> romd_mode (i.e. Read Array mode), but the pflash is not in romd_mode
> when processing MemoryRegionOps->write() commands. Since the RAM can
> change even when !romd_mode, relax the assertion so it only checks
> rom_device.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4490
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Elliot Berman <elliotjb+anduril@elliotjb.com>
> ---
>   hw/block/pflash_cfi01.c | 5 ++++-
>   hw/block/pflash_cfi02.c | 3 +++
>   system/physmem.c        | 2 +-
>   3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 486fc6350d..66ecdb0969 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -388,12 +388,15 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr offset,
>       return ret;
>   }
>   
> -/* update flash content on disk */
> +/* update flash content on disk and invalidate the guest view of RAM */

  /*
   * Flush modified flash content: mark the range dirty, invalidate the
   * TBs translated from it, and write it back to the block backend.
   */

>   static void pflash_update(PFlashCFI01 *pfl, int offset,
>                             int size)
>   {
>       int offset_end;
>       int ret;
> +
> +    memory_region_flush_rom_device(&pfl->mem, offset, size);
> +
>       if (pfl->blk) {
>           offset_end = offset + size;
>           /* widen to sector boundaries */

I'd like feedback from migration maintainers: could we be writing
staled content during live migration? Or maybe we are already safe.
invalidate_and_set_dirty() gets DIRTY_MEMORY_MIGRATION set via the
memory_region_get_dirty_log_mask call. Hmm so this change also fixes
migration then. If confirmed, worth mentioning in the patch description:


   Direct writes to the flash RAM were not marked dirty for migration,
   so pages reprogrammed during pre-copy were not re-sent, and
   postload_update_cb() wrote the stale content to the block backend.
   The memory_region_flush_rom_device() call now also fixes this.


> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 4f72c438c0..22b27366ee 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -419,6 +419,9 @@ static void pflash_update(PFlashCFI02 *pfl, int offset, int size)

Same comment update missing:

  /*
   * Flush modified flash content: mark the range dirty, invalidate the
   * TBs translated from it, and write it back to the block backend.
   */

>   {
>       int offset_end;
>       int ret;
> +
> +    memory_region_flush_rom_device(&pfl->orig_mem, offset, size);
> +
>       if (pfl->blk) {
>           offset_end = offset + size;
>           /* widen to sector boundaries */
> diff --git a/system/physmem.c b/system/physmem.c
> index db3dda563d..c532e29571 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3162,7 +3162,7 @@ void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwaddr size)
>        * necessary.  Other memory regions should use the
>        * address_space_read/write() APIs.

      * The ROMD mode is not checked: the RAM backing a ROM device can be
      * modified while the region is in MMIO mode.

>        */
> -    assert(memory_region_is_romd(mr));
> +    assert(mr->rom_device);
>   
>       invalidate_and_set_dirty(mr, addr, size);
>   }
We need to update the API contract:

-- >8 --
  /**
   * memory_region_flush_rom_device: Mark a range of pages dirty and 
invalidate
   *                                 TBs (for self-modifying code).
   *
   * The MemoryRegionOps->write() callback of a ROM device must use this 
function
   * to mark byte ranges that have been modified internally, such as by 
directly
   * accessing the memory returned by memory_region_get_ram_ptr().
   *
+ * This function may be called whether or not the region is in ROMD mode:
+ * a device that leaves ROMD mode (see memory_region_rom_device_set_romd())
+ * while it is being programmed must still flush the modified range, so 
that
+ * translations created before ROMD mode was left are not reused once it is
+ * entered again.
+ *
   * This function marks the range dirty and invalidates TBs so that TCG can
   * detect self-modifying code.
   *
- * @mr: the region being flushed.
+ * @mr: the region being flushed; must be a ROM device.
   * @addr: the start, relative to the start of the region, of the range 
being
   *        flushed.
   * @size: the size, in bytes, of the range being flushed.
   */
---

Please split this patch in 2, first the memory_region_flush_rom_device
change then the pflash ones (2 distinct subsystems, better to bisect
or partially cherry-pick). Change LGTM otherwise!

Regards,

Phil.

