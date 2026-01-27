Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D269CD2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 19:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkp6j-0007XJ-NF; Tue, 27 Jan 2026 14:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkp6f-0007T5-GP
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 14:52:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkp6X-00052V-Lg
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 14:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769543516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jnPd7XOrzVzdL41eC+RaAWPzPYJ1wubhK5FzPeW1fiM=;
 b=Wsk/zyRB5fH5kk5agdBC2XDP/rumOc5WH5WBR0RCo18uUJfUivGGbKZotsHVUrt5Lv3VGs
 Krf07ypYLSXX4fVJpa4HUw9CvAywgvDzMgeFngT1krof0CResduk9PVE5Y0Yel+/MYoLf4
 eHEMwnygGsxcoEkZEbzGCWi2DSkfVJU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-ZVfPhOlrPiiJtomBfWZnxA-1; Tue, 27 Jan 2026 14:51:55 -0500
X-MC-Unique: ZVfPhOlrPiiJtomBfWZnxA-1
X-Mimecast-MFC-AGG-ID: ZVfPhOlrPiiJtomBfWZnxA_1769543515
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5032e68560dso31850321cf.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 11:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769543515; x=1770148315; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jnPd7XOrzVzdL41eC+RaAWPzPYJ1wubhK5FzPeW1fiM=;
 b=mZLAL3klFLlMBnkmPB221/fu0IuDbV3jxZ1CNsAfwMHUgrNvAws1uYmryy/ZAH4W0W
 n3uH6ifA6W7Iw+v4QzHQbNN5U5fHTHNVonO6gTc1D2fxtVCFVg8SfO+0QLP91rD+lJuE
 Xpps/plKpjW7MGTUi+r2+D8R01tBp5Oar1iyW/pqHzxlqyGxywLV3n3yifiqv3oUmvw2
 GE/M1gu67/VOqmYzQjtZqZ7Gv2wJagoiXUuAWPvMIso0u2x925YuVw//cpU6s0VDY83D
 SrGd+n069ASmuY5efdC9DpUe7OtloFlMwo/sGnAqOnd00WHpMssi0gEkj5PCKN/NbG3B
 37oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769543515; x=1770148315;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jnPd7XOrzVzdL41eC+RaAWPzPYJ1wubhK5FzPeW1fiM=;
 b=SmL1ZZvV4HKI/px+CqPkYvOsWznOeZVDhRm1n09mXtJ9hdg0F0ZkEgRt57j7d/1cEh
 6ybQew0W2oYqS64Stu/JI6jYKjjCz2rZg1XRSc1ilETboKClmxqA1TTKcdm2SDgvuM6O
 JekSFzIEKWus1X4hqfLGCGRb/ibOVOcUrl6niRjMz+Pnomltib9SWOWgy6OcZazi012Q
 iajA5mvdnHJTyMAwjuIT/g4G7r6D9RbHSdoNLtwWPg/y1WAcOjVND6zcBl+8n/Use2Mm
 ElFo0/PF41CDlF+/iIf+zID4jnt1+wWO0fptFSywIytyh+XC7bGvIal6dq1NsgxwoEfv
 2afQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNqkv2Uq3qhhN2cZAPhneLfwmvVmxy8pxPyvWd6JpbppgC9+O2qkFN+OmMlHGJOTfDWkCW1s7dAZMi@nongnu.org
X-Gm-Message-State: AOJu0YyYM8u2uDW8994WOaP17upGj+SX6Hrkqx4U2jNCvP0XRWyZm2Zh
 z7pUXtcFE3P/9rWTvl70KdrSWvepuiqjNlvTRPB4OGABM0mpC+h9diQlZgVCDe8G4Er8G2CBrOI
 2wRsijRUV5GqWtg3IfhWSl8oVSiY7c5IELvDFiGNUoOXdkcn3iih347YN
X-Gm-Gg: AZuq6aLMvXiRWD7rQNeWniOzSVr30SCltdnpRcwg009FNHp8uj+iubag6KUKgK8YEp2
 0NfPGwVdxdZ9V0LT/8FRkfBm6QvG/fx+oAYpf3gy48+Oz9D8onYlz2lyzEjZl/hBzuT2ag2lCzh
 W4/yNYMUrBz3rjwq5aln57hfPfhne3kv8FEIoaMykvsnbz2kF0OWIE57wZyV42az7qd/WPqVETZ
 UgIGooXlr4/JGRTinkyrb+7ZyPWa+dcsNv7DJycEmj3PIl7ax/56cU6qxfGAEt5LdCOVxNgIMbq
 vhxRUTdP1lO9NgBW2qYGb0zhKLQwaxdZmeYIAsU0HjA2IbJNJzwNDBS45XyOQAUgA7E9SLeNmGN
 zeq0=
X-Received: by 2002:ac8:7d4f:0:b0:4f1:ab66:7c43 with SMTP id
 d75a77b69052e-5032fb1d4dbmr34193531cf.74.1769543514623; 
 Tue, 27 Jan 2026 11:51:54 -0800 (PST)
X-Received: by 2002:ac8:7d4f:0:b0:4f1:ab66:7c43 with SMTP id
 d75a77b69052e-5032fb1d4dbmr34193231cf.74.1769543514077; 
 Tue, 27 Jan 2026 11:51:54 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50337470cd8sm2195361cf.13.2026.01.27.11.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 11:51:53 -0800 (PST)
Date: Tue, 27 Jan 2026 14:51:52 -0500
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 00/10] Implement memory_region_new_* functions
Message-ID: <aXkXWGho7lnJ-gwX@x1.local>
References: <cover.1769362313.git.balaton@eik.bme.hu>
 <CAFEAcA_jS3hef=dhxZ5s7MReSW4ir+jMUGwu+RjD_JP7ZRrRXQ@mail.gmail.com>
 <0118dc9b-d467-7f6b-92a8-4f42760ecb6c@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0118dc9b-d467-7f6b-92a8-4f42760ecb6c@eik.bme.hu>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 27, 2026 at 03:10:28PM +0100, BALATON Zoltan wrote:
> This series does not convert everything but opens the way to do that and
> simplify objects by only storing things in the state that are really needed
> by the object and let QOM manage what it can. I'd really like to avoid
> having a list of unused stuff in the state struct just because I can't use
> something that works and documented just no API to actually use it. Cf.
> sii3112 state after this series:
> 
> struct SiI3112PCIState {
>     PCIIDEState i;
> 
>     SiI3112Regs regs[2];
> };
> 
> vs. your standard:
> 
> struct SiI3112PCIState {
>     PCIIDEState i;
> 
>     MemoryRegion mmio;
>     MemoryRegion bar0;
>     MemoryRegion bar1;
>     MemoryRegion bar2;
>     MemoryRegion bar3;
>     MemoryRegion bar4;
>     SiI3112Regs regs[2];
> };

The latter solution is fine at least to me.

I respect your preference on how it can be done, but IMHO it is subjective,
and I tend to agree with Peter that we should try to stick with one way of
solving problems, unless very necessary.

In the last three patches the MRs do not look need dynamic deallocation to
me at all..  Introducing fully dynamic MR allocations only for those is an
overkill to me.  I'm not fully convinced we need to merge 600+ new LOCs for
new APIs just for them.

We have real but rare users of dynamically allocated MRs, currently AFAIU
we're leaning towards having an object wrapping the MRs needed, when one
wants to provide a complete lifecycle for the MR so the memory backing the
MRs can be freed completely separately from the parent object.

Thanks,

-- 
Peter Xu


