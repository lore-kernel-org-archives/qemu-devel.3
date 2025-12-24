Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0472DE776F0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 19:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYU8C-00024d-5N; Wed, 24 Dec 2025 14:02:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYU8A-00024C-Db
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 14:02:42 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYU88-0003jz-FV
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 14:02:42 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b7ffa421f1bso1229727166b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 11:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766602958; x=1767207758; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ef+FuyNNamUO0dRYQj6L/qYxkfhgwJJe9wxGcjCTN4g=;
 b=MY2H/ohuwpfK9xTdRuukEclmAvBRJEPowFYcN8UeoWCxr1EoGfEfX2e7Tj58VFOASo
 uLlNcod7cbkgqL0E5ghMFGEAEIlL2p6ARfYNcxM2JkhwF1DWA9kidyf1uyrrMonLiQ+i
 +x92xLt3fP6++Dh6Hol7Z6FZyiXwdmz2r7sg7oy6x7twFT5ZyiXaoPA/75PU2EihfIP0
 2uVPYABs6hUy5r0zGUomzAm57Xj8gIJbC0xoZFxMw//N1O9e++f1xsxpLjOUwROgi8n7
 brxBluavrtHmYhMt9NDfOSXj+CPPpG83tnn1dzV9xKJsygoL46Fbk+1DdP+zFZsyODg4
 npSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766602958; x=1767207758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ef+FuyNNamUO0dRYQj6L/qYxkfhgwJJe9wxGcjCTN4g=;
 b=A1JugzHSAFZb8z2CBcKKXw0pqHkt8LEBsE1M5JRAKeFbEE3R8kG69V9WYUqEX5lU1S
 8PvkH0agv2U5ELwPA+rfH+ydmAZYNHuBzP8uAUmbpnPESETfxWo0adJoG8uy2ltaj8dV
 PekUmahPbVRTx6v/QpgFimR7y5n4HmDnWAVjsONdvxy2EeF2i3khZ1wnai9prLxeqhRn
 MGaAFqipmlJog6olredptF7R1QaS6RcqXthE8Uxyky79aY/QgugBpASn1MKvalNefmyc
 LE1gmC2auIbxgwcRCq/zDYINjhpDoVebLYXzNHZB5jeuyzro7ju33vZMKq/LBOFCbQmW
 pdzA==
X-Gm-Message-State: AOJu0Ywx1toszyK+/fR1efKGrdQeTRILpf9LzINvK/cK87PmGPvwvgea
 EkAUr+8I+Vo06wn88aEstCH/2X+cUhmU6nlbJpU9oXOgR98+NuDLGSJpZXZnpGl8eF4GJi5sIb8
 mch1QZwjaQJ8fAZJ38WeJwKI38Dj7JrvxC/fhQNj6Qw==
X-Gm-Gg: AY/fxX7AZGYB3N/M9QEPt6+df/BnzrVS2F7GkepI8iLPR80ETlpA5TQlVp+onYF+vEP
 BuZKikQrVPd5oWOMOUFxQ02PpY6Z4cD5OMbL9M6ITGfLrPrH0ZZ77BrSdBLH5C4xHm4lfVQa0CK
 fRSNZyhpegTx5Uqoig0JPLKUa+eJ92rNy1vYMgUd7+G+k2ngUci9rUwhl99UK8hFKYGRTPEVP1w
 4BIJwFClw6LxJd+ViKZEFMJLW6YUBJiVUOKy2p+13gO17POl+6B7dgbBzzFLAUMpvMxuk8=
X-Google-Smtp-Source: AGHT+IH4zDc6YZwervhsWvcLZ8QY7wSmC7Y/nUBZw566KunpQZcH1nRQmZ6jpMnlpGXvDRHw1DJcmN8Xs5uIJBqQmgk=
X-Received: by 2002:a17:907:8688:b0:b80:456d:bd99 with SMTP id
 a640c23a62f3a-b80456dc544mr1804062966b.19.1766602958190; Wed, 24 Dec 2025
 11:02:38 -0800 (PST)
MIME-Version: 1.0
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-3-philmd@linaro.org>
In-Reply-To: <20251224152210.87880-3-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 24 Dec 2025 21:02:12 +0200
X-Gm-Features: AQt7F2ruccuonUS4_QZBePYQ5ZNheMPkPF9USOlloHzDzve5lJ1vyqNMrcVuexg
Message-ID: <CAAjaMXak2pQRVi=XFu2e1OMj1EzvpZtCnHH8Es3bHO4GWa0gxg@mail.gmail.com>
Subject: Re: [PATCH v3 02/25] system/physmem: Convert DEBUG_SUBPAGE printf()
 to trace events
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu <peterx@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Anton Johansson <anjo@rev.ng>,
 David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Dec 24, 2025 at 5:22=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Defining DEBUG_SUBPAGE allows to use raw printf() statements to
> print information about some events; convert these to tracepoints.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


>  system/physmem.c    | 29 ++++++-----------------------
>  system/trace-events |  6 ++++++
>  2 files changed, 12 insertions(+), 23 deletions(-)
>
> diff --git a/system/physmem.c b/system/physmem.c
> index 1292f49095f..7e914ecf648 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -91,8 +91,6 @@
>
>  #include "memory-internal.h"
>
> -//#define DEBUG_SUBPAGE
> -
>  /* ram_list is read under rcu_read_lock()/rcu_read_unlock().  Writes
>   * are protected by the ramlist lock.
>   */
> @@ -2903,10 +2901,7 @@ static MemTxResult subpage_read(void *opaque, hwad=
dr addr, uint64_t *data,
>      uint8_t buf[8];
>      MemTxResult res;
>
> -#if defined(DEBUG_SUBPAGE)
> -    printf("%s: subpage %p len %u addr " HWADDR_FMT_plx "\n", __func__,
> -           subpage, len, addr);
> -#endif
> +    trace_subpage_read(subpage, len, addr);
>      res =3D flatview_read(subpage->fv, addr + subpage->base, attrs, buf,=
 len);
>      if (res) {
>          return res;
> @@ -2921,11 +2916,7 @@ static MemTxResult subpage_write(void *opaque, hwa=
ddr addr,
>      subpage_t *subpage =3D opaque;
>      uint8_t buf[8];
>
> -#if defined(DEBUG_SUBPAGE)
> -    printf("%s: subpage %p len %u addr " HWADDR_FMT_plx
> -           " value %"PRIx64"\n",
> -           __func__, subpage, len, addr, value);
> -#endif
> +    trace_subpage_write(subpage, len, addr, value);
>      stn_p(buf, len, value);
>      return flatview_write(subpage->fv, addr + subpage->base, attrs, buf,=
 len);
>  }
> @@ -2935,10 +2926,8 @@ static bool subpage_accepts(void *opaque, hwaddr a=
ddr,
>                              MemTxAttrs attrs)
>  {
>      subpage_t *subpage =3D opaque;
> -#if defined(DEBUG_SUBPAGE)
> -    printf("%s: subpage %p %c len %u addr " HWADDR_FMT_plx "\n",
> -           __func__, subpage, is_write ? 'w' : 'r', len, addr);
> -#endif
> +
> +    trace_subpage_accepts(subpage, is_write ? 'w' : 'r', len, addr);
>
>      return flatview_access_valid(subpage->fv, addr + subpage->base,
>                                   len, is_write, attrs);
> @@ -2964,10 +2953,7 @@ static int subpage_register(subpage_t *mmio, uint3=
2_t start, uint32_t end,
>          return -1;
>      idx =3D SUBPAGE_IDX(start);
>      eidx =3D SUBPAGE_IDX(end);
> -#if defined(DEBUG_SUBPAGE)
> -    printf("%s: %p start %08x end %08x idx %08x eidx %08x section %d\n",
> -           __func__, mmio, start, end, idx, eidx, section);
> -#endif
> +    trace_subpage_register(mmio, start, end, idx, eidx, section);
>      for (; idx <=3D eidx; idx++) {
>          mmio->sub_section[idx] =3D section;
>      }
> @@ -2986,10 +2972,7 @@ static subpage_t *subpage_init(FlatView *fv, hwadd=
r base)
>      memory_region_init_io(&mmio->iomem, NULL, &subpage_ops, mmio,
>                            NULL, TARGET_PAGE_SIZE);
>      mmio->iomem.subpage =3D true;
> -#if defined(DEBUG_SUBPAGE)
> -    printf("%s: %p base " HWADDR_FMT_plx " len %08x\n", __func__,
> -           mmio, base, TARGET_PAGE_SIZE);
> -#endif
> +    trace_subpage_init(mmio, base, TARGET_PAGE_SIZE);
>
>      return mmio;
>  }
> diff --git a/system/trace-events b/system/trace-events
> index 82856e44f2e..6d29a823f04 100644
> --- a/system/trace-events
> +++ b/system/trace-events
> @@ -35,6 +35,12 @@ find_ram_offset_loop(uint64_t size, uint64_t candidate=
, uint64_t offset, uint64_
>  ram_block_discard_range(const char *rbname, void *hva, size_t length, bo=
ol need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d =
fallocate: %d ret: %d"
>  qemu_ram_alloc_shared(const char *name, size_t size, size_t max_size, in=
t fd, void *host) "%s size %zu max_size %zu fd %d host %p"
>
> +subpage_register(void *subpage, uint32_t start, uint32_t end, int idx, i=
nt eidx, uint16_t section) "subpage %p start 0x%08x end 0x%08x idx 0x%08x e=
idx 0x%08x section %u"
> +subpage_init(void *subpage, uint64_t base, uint64_t len) "subpage %p bas=
e 0x%08" PRIx64 " len 0x%08" PRIx64
> +subpage_accepts(void *subpage, char access, unsigned len, uint64_t addr)=
 "subpage %p %c len %u addr 0x%" PRIx64
> +subpage_read(void *subpage, unsigned len, uint64_t addr) "subpage %p len=
 %u addr 0x%" PRIx64
> +subpage_write(void *subpage, unsigned len, uint64_t addr, uint64_t value=
) "subpage %p len %u addr 0x%" PRIx64 " value 0x%" PRIx64
> +
>  # cpus.c
>  vm_stop_flush_all(int ret) "ret %d"
>
> --
> 2.52.0
>

