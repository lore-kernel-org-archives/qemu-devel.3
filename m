Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150E0FCB61C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXqA-0004EU-9T; Fri, 06 Mar 2026 11:15:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vyXq3-0004BE-SJ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:43 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vyXq0-00078B-4X
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:43 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-5069df1d711so80350751cf.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 08:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1772813739; x=1773418539; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GbmWTzpazKoJULiA6CTXvYX+uhQm31hgupo0LDSYz2g=;
 b=dzI1uoFWecAN+8P1ZsbOmvDur0Agj29O6Uiji28DFLWzIoQAyflHAIfcqRN4f9KlDG
 bqd6y5T0aUBN8btnMESETg7rdKBjcJIulnq06lkcHB2tQjk4Y6qTe2GT73o9CUBzO5Dj
 ZQDKjcGTXL9Aw0myAbtlGXGL+Qt7Pif7ZPynCr5uvO8Z1jxXEXqqZcknCqMyo++aXNCE
 lG9KR+FRpkM6UdtVb4jWNVn8W8opsC4PQ7hZ39GGiz4ZJI6yneF85dEdEdawEJqr5M1S
 vdS75o7UD6boJEVqgPLw2oklI67odowMr6xeVUYjbI6mTpmyw2i2qiNtfsduxaS1Y8ZB
 YIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772813739; x=1773418539;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GbmWTzpazKoJULiA6CTXvYX+uhQm31hgupo0LDSYz2g=;
 b=OK5MT0Zllwy9QJavcOKPhSBsbpOzo2QpsT67aX0WruvIVtDGX7bJBNDQU3H2pC6+vZ
 cX8FT74gspHI32FUcesQ1FbhyC/0Ehn34trUTzQ5brm6kZ6oC3fk8Zc6KeQm+CxXjMjP
 11rYl3ug69kq8UwFsW83PDiHsk7qihiizkjE5c5ZRmrbM12OQAiGZFuwaeeXjygtvqII
 93vW1b10tP373g/RP3pmNgZBSjqHcXxKntNtstAfvhe/pVVLW8FVrpblbEb+HRpGb6Vb
 UiTStiyZQhIR8CB/ekI17sOvKMVxNJdoHIXKu6eXu7qlPzB0A7OEjV5ArVJKrT6Tmsnc
 tpnw==
X-Gm-Message-State: AOJu0YxYhLsTKtyIL2IsxEBFjpLsf+LdnyTJSaW7Wp0PBOkdHS7oYW5Q
 8Kbmm7zsu2feY7zZb7o7FIphPpf6gffy7adTyoUsoUhlzCEmiRmw02Absi3zTnIHb3I=
X-Gm-Gg: ATEYQzw86TlfYYCUEpAgb/GnifYBAN92EMqNzafXgavwWHCMAWOYic79ggo44dlkDRo
 zXGsphw51RSI5pujchjstYQSHzs2mdzVGF1OS3tCMab+dh3IhAAaQjxSDwGUqQAbku60b9K3KZe
 qOsaVWguA9OIt+kO6+ifUZJMuPsB5yLIA52WQwkkUFpmkSyqNLdP+DL82NEhQOpIFBVzm8Cw71q
 w6RMnBqpbN8Uttm/GK90lUDGlL+mqvs6PY34/696BLkXwkmW2A1Uo71CxYG8S+3uF8czm7vniHT
 oUag7/6Xvg75bZUnpVqlipcgHTe2DFDGUExwt1tw1nVYR6e1HAyt7FxtDpGqa+mgrhmBqvn7Cns
 Glq7WDgHs/hqw/roFsPZHpHnqnOaNokyoc2ha0JBBHe1y0bGbTyO9l/XCzuhd5Zkg/7O+v6mDPx
 qY7PMP7ja70jkuJs6LM0zrcnONDeFe7K6sg3j9nsORtcjIES0+Kiv5RLiDAXevViWRhMSupdCsx
 sqgG0mRgLjKllDE2oO4
X-Received: by 2002:ac8:5acc:0:b0:4eb:a6c9:e839 with SMTP id
 d75a77b69052e-508f4960f26mr30743651cf.47.1772813737094; 
 Fri, 06 Mar 2026 08:15:37 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-508f66b620dsm12901861cf.23.2026.03.06.08.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:15:36 -0800 (PST)
Date: Fri, 6 Mar 2026 11:15:34 -0500
From: Gregory Price <gourry@gourry.net>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, lizhijian@fujitsu.com, anisa.su887@gmail.com,
 armbru@redhat.com, david@kernel.org, imammedo@redhat.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com, mst@redhat.com,
 nifan.cxl@gmail.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com, venkataravis@micron.com, xiaoguangrong.eric@gmail.com
Subject: Re: [PATCH v7 1/3] hw/cxl: Use HPA in cxl_cfmws_find_device() rather
 than offset in window.
Message-ID: <aar9pq7_-kqcB6MC@gourry-fedora-PF4VCD3F>
References: <20260306121151.883-1-alireza.sanaee@huawei.com>
 <20260306121151.883-2-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306121151.883-2-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=gourry@gourry.net; helo=mail-qt1-x829.google.com
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

On Fri, Mar 06, 2026 at 12:11:49PM +0000, Alireza Sanaee wrote:
> This function will shortly be used to help find if there is a route to a
> device, serving an HPA, under a particular fixed memory window. Rather than
> having that new use case subtract the base address in the caller, only to
> add it again in cxl_cfmws_find_device(), push the responsibility for
> calculating the HPA to the caller.
> 
> This also reduces the inconsistency in the meaning of the hwaddr addr
> parameter between this function and the calls made within it that access
> the HDM decoders that operating on HPA.
> 
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>

> ---
> Thanks to Li for the tag.
> Change log:
> v6->v7: No change.
> 
>  hw/cxl/cxl-host.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index f3479b1991..a94b893e99 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -168,9 +168,6 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
>      bool target_found;
>      PCIDevice *rp, *d;
>  
> -    /* Address is relative to memory region. Convert to HPA */
> -    addr += fw->base;
> -
>      rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
>      hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
>      if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
> @@ -254,7 +251,7 @@ static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
>      CXLFixedWindow *fw = opaque;
>      PCIDevice *d;
>  
> -    d = cxl_cfmws_find_device(fw, addr);
> +    d = cxl_cfmws_find_device(fw, addr + fw->base);
>      if (d == NULL) {
>          *data = 0;
>          /* Reads to invalid address return poison */
> @@ -271,7 +268,7 @@ static MemTxResult cxl_write_cfmws(void *opaque, hwaddr addr,
>      CXLFixedWindow *fw = opaque;
>      PCIDevice *d;
>  
> -    d = cxl_cfmws_find_device(fw, addr);
> +    d = cxl_cfmws_find_device(fw, addr + fw->base);
>      if (d == NULL) {
>          /* Writes to invalid address are silent */
>          return MEMTX_OK;
> -- 
> 2.43.0
> 

