Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B164AC54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpNzL-0008Ch-2N; Thu, 30 Jul 2026 06:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpNzJ-0008C3-4p
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 06:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpNzH-0005UF-AY
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 06:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785407258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W8y2sfaXiCYkgQ3HrJ3wLaya96QRcRoNnbVpCPmktsQ=;
 b=MBD3xuPFhknn2hB/XiYjPBP8DCSS5+27ahD+xbwtttwhGiBdFUxg4xnJGtHsXHDVAkDHNW
 JQXcRnzYOMHbMUliqoxuv4GQfuMU2JnkjH7dBkNtNTIFgEBM36IenAh9GWiYII3aXt49Ex
 K8AHF7tiDGapUsmrP8JNWvkFb5IEECM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-wQjmQ5JXNjipAIP7ycZ19A-1; Thu, 30 Jul 2026 06:27:37 -0400
X-MC-Unique: wQjmQ5JXNjipAIP7ycZ19A-1
X-Mimecast-MFC-AGG-ID: wQjmQ5JXNjipAIP7ycZ19A_1785407256
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f8580ed9eso1779215f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 03:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785407256; x=1786012056; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W8y2sfaXiCYkgQ3HrJ3wLaya96QRcRoNnbVpCPmktsQ=;
 b=d21RIn4XoAyof2U00TRiv3zvB1HED7rWudaxc4Jj9+k32D3xyn6mt2EuDjFWNKCMB/
 Xy2aWeHeolPlYv1uoEwpArJtNFLOZ6PMZRmtJThJ+bERX9qgA60E4Ykp2xMGLau28VWR
 avGY009B2MRBeAOpMjRS5u0+Ime0swuBQ7RUJMGJoRPsGVRyFnez8KD40j/pRS6H9VeW
 LCmHxnJSRYF0jvHuTQZNCi4eQEO+8ekOckR1fbCGnIvotLciv0mG57eZ/FM+azfm3wwk
 OZTsOFtbYLgAmRuF31PdSPJqIX/OLs2f5UsvcEdw0NVN9zjzrtGItdumL97uyqj59qJc
 zpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785407256; x=1786012056;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W8y2sfaXiCYkgQ3HrJ3wLaya96QRcRoNnbVpCPmktsQ=;
 b=YnDtlre1OB6MMce0wMsdGuEDqhpVhvXhpJEODg9yukSbdM74741UK8TBDxR5K40Iay
 alXvEz22zJsB0vejmMVU/L/vKww6wVQMvZlfWPaSvw3vNTc14v6dZcupg0fpI2LzFsIs
 TQMB9hLH0opvduN69MwvbXE9m3uZzcLi5+sflf+TY73pen/BLK/ZRYn9h5C+E2IzOt/X
 lE81Pebuu/9dmg/u7KhCVM0qq6sLjNgF4PkS0U6xJiD/C2DN4rTqYB5wgXPlPkUH0cTU
 p0ydr2ERplmjSQwUEiCP0+nNz+Kqx/110gjyPHaCMhP/3XW04YUoC/VQh4shIpfmzW3O
 P+Zw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoR2cSyVT2/2qPB7ARvt9P41uJS0gPAgSA1GUhM9lSdmzYiM41K1Rq4MNRQS9shy7yTOOW+9HB00OJQ@nongnu.org
X-Gm-Message-State: AOJu0Yz061MEYqGyTr1Zd6M/nXksoPLHnvDR4nxMwGyDYcv7AjgcfE72
 zX3hYAv7rpzlp2tKyUZ6xPp4Jw7DRhznJpuWP3CDLWwSGOyua6vHaygDyyvmmHOkEyaI2/pWKc+
 a7YRSZ9VAldUuPYiBG8I3yW5Lvs7MKg2eFKlRQNjmL+Vuy2fu/nlEms38
X-Gm-Gg: AR+sD12ZMPjuxaqQ5YDSflG5ye62fn+4fQ+hBj8pztNDnmxtenXZ0PKtXHDTULcyqhb
 C+P0U1aQ1g9K4IUkcsjJ4SvTU1mFdAtBzWqlSzQQp6FsnKvdGFhmkdqQVtrhNIhYxrh+iw4kHjC
 rsbd+bsSF9qDc3WLBaBqrvJXIQzL8OV4kNmOzK4PBwyIm9wp0T+gQ4YGaFGxMxL+NZxiSkAXjcB
 o5PAenA2xKDt1bvv7dL/0yFcPiCUB2e08zDyp3tKhvaEfWqM1zJ3paEWLG0WQuRN1bIUQ0XrkDl
 zHfN3wmLUSDfr+g0s1Q7ToqumI1zQtTlkPudv8zaP0v6qFF0usVlW4fJ/X7uiRp7Sk4PlKXWUiI
 AAamT3qt65bhp0inikD46N4U=
X-Received: by 2002:a05:6000:706:b0:47f:8ce3:d8f2 with SMTP id
 ffacd0b85a97d-47fc842d33bmr2588420f8f.56.1785407255624; 
 Thu, 30 Jul 2026 03:27:35 -0700 (PDT)
X-Received: by 2002:a05:6000:706:b0:47f:8ce3:d8f2 with SMTP id
 ffacd0b85a97d-47fc842d33bmr2588369f8f.56.1785407255138; 
 Thu, 30 Jul 2026 03:27:35 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88d6e5bsm5166837f8f.3.2026.07.30.03.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 03:27:34 -0700 (PDT)
Date: Thu, 30 Jul 2026 06:27:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, philmd@oss.qualcomm.com,
 richard.henderson@linaro.org, alex@shazbot.org, berrange@redhat.com,
 philmd@mailo.com, david@kernel.org, clg@redhat.com,
 pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v5 2/3] system/memory: Use qemu_ram_move() for directly
 accessible regions
Message-ID: <20260730062155-mutt-send-email-mst@kernel.org>
References: <20260728031731.286666-1-gshan@redhat.com>
 <20260728031731.286666-3-gshan@redhat.com>
 <20260729182316-mutt-send-email-mst@kernel.org>
 <CAFEAcA8nxsXNPuqOoc4DGnHbCKQ-pBJib4JhXnYkzMg79GMfAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8nxsXNPuqOoc4DGnHbCKQ-pBJib4JhXnYkzMg79GMfAA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Jul 30, 2026 at 10:24:32AM +0100, Peter Maydell wrote:
> On Wed, 29 Jul 2026 at 23:35, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jul 28, 2026 at 01:17:30PM +1000, Gavin Shan wrote:
> > > +void qemu_ram_move(void *dst, const void *src, size_t n)
> > > +{
> > > +    uintptr_t test, len;
> > > +
> > > +    if (src == dst || n == 0) {
> > > +        return;
> > > +    }
> > > +
> > > +    /*
> > > +     * Maximal length of aligned access that are determined by @src,
> > > +     * @dst and @n
> > > +     */
> > > +    test = (uintptr_t)src | (uintptr_t)dst | n;
> > > +    len = test & -test;
> > > +
> > > +    /* Overlapping buffers, unaligned or oversized access */
> > > +    if (n > 8 || len != n) {
> > > +        memmove(dst, src, n);
> > > +        return;
> > > +    }
> >
> >
> > This part I don't get exactly. It's fine on most arches I think.
> > x86, power...
> >
> > But here is aarch64 for example:
> > https://codebrowser.dev/glibc/glibc/sysdeps/aarch64/memcpy.S.html
> >
> > it says
> >    It uses unaligned accesses and branchless sequences to keep the code small,
> >    simple and improve performance.
> >
> > so if the point is to get rid of unaligned accesses to BARs, are you sure
> > it achieves this?
> 
> The idea is rather just to ignore the unaligned-access-to-not-RAM
> case as "only a theoretical issue" and default it to memmove().
> If anybody reports an actual problem we can think about it then :-)
> 
> -- PMM

Well given the only reported case of virtio DMA into vfio memory we have is
GH100 and that one is mapped MT_NORMAL, I'm fine with that.

I feel extending vfio to report the mapping type to userspace might
not be a bad idea down the road, though. "Directly accessible"
is a very rough approximation to the rich variety of mappings
available across architectures.

-- 
MST


