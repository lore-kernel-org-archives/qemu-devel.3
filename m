Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75399CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBvew-0006eK-0k; Thu, 23 Oct 2025 09:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBveu-0006e5-Vs
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBver-00047q-O6
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761227231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=11BZObUEMo9xjmVKVDgGRPtSV3Z2bXiczkY4zrJQvQw=;
 b=c/hfWgW0ng61QG6szVwwyBC8f0IKv9eLUwHmVMN+gLZOEzq9ysm8mGWD9uLA7WFT6PR9jQ
 xO9Msb17ZDrgAFB1XjjGEgeg3sZGa6SEVRXoyhPDaOcxbvIqpKz2PBHyWrcwCXqIUFsyA6
 /H2RUg/fHaui/NmGKBCgnDBF6RwlREs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-svO2fzjlNo-RZn8N4ilYUA-1; Thu, 23 Oct 2025 09:47:10 -0400
X-MC-Unique: svO2fzjlNo-RZn8N4ilYUA-1
X-Mimecast-MFC-AGG-ID: svO2fzjlNo-RZn8N4ilYUA_1761227230
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4e8b2052f07so20506311cf.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 06:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761227230; x=1761832030;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11BZObUEMo9xjmVKVDgGRPtSV3Z2bXiczkY4zrJQvQw=;
 b=nUfd+FgUkwQQg+bQeioVodFLLN1gHIscOFjvPmgFEFYppGQNiwjrhBDgVa2LCvv2/7
 tiEt4WAcBeiHofGmECkQkvCxGYdYGlP+I1CI43PlmBydctBz39aljHTmgZaQgRFKqi1y
 CLd6PWeHyZSLIoiG3w5JD+sXVsCNv2NEhgKFE9kxFzQ4JIIxRJ9St+KPNoQegQkoUJw2
 a8tWvy6Bqy7Wzp38cvvD+9GWmDRvXAEObdEVkpIc04wqY70wr9HlauR/sEXJYgLLf/Ud
 WtALpSK8yFON7BhXb6KZSzFEwIuJ50joEDqjfVLbikurnobBNXwbq6dLKACjWz1W3Wil
 CjKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVc678jCv1ugFKYTQBblOyeJryKXihNr5kcJ/BHXqfAwkpOaKcDyYS7sS/UAuMqCLhSKdeqeGXhFiE@nongnu.org
X-Gm-Message-State: AOJu0YzgokLnohqTpep3eoFa/jZae09CJWrHd7rVifYt1g8LKWyzF5IL
 9i1vZoiHIeaCH8fw2nwhSIYzn0Hc9oHf2l3LO81Pctbd+MXwOgNCwxqK8HDc6LfhHi9uo4YhNUP
 +pA12LMMzImcmYrMLcpyljKhpeeIDUTs9PIa/ulKyFgg/b5S7PTsV6F8f
X-Gm-Gg: ASbGncvhmfMSkX+zvJ9MDniXbsPDAninMQ21twiD1x+vfo4GJcoynWZfxrwdV+J6knw
 SamIOpHtjdr+OVE1wKoIGF1+jzAAPB3orF7vHn3z64ifiqGUR/k6DSrEntLUu5ft8r/YAQYk38y
 NM5TsxHFfxxoUFueW9e/6ISYaltl367qLf0Jz5FmxKJ6LEj5m8O8Vtp7G9iKcsu7pwPYmUagCev
 nAWdVDrBdzwk4sODRx2jFVJt3hRz4evzSc9FduUxzcrEWNdZV3tPytAIvg7GvBcBrDpqeMH5b9n
 uwLQIuO66OoSAjPfyCl9I67JTby4VEL5QdiQd/Fno3IbVrWxXV0HZumaf0ktjBtHJ14=
X-Received: by 2002:a05:622a:a28a:b0:4b6:cbd:8c91 with SMTP id
 d75a77b69052e-4eb732d4f46mr80003741cf.5.1761227229532; 
 Thu, 23 Oct 2025 06:47:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH58A2n3T7td4XkD3DM5bwNwq61heDDy+ylhz6auBt3gJNmsx2tPdZFhb5YdPsUCwEBiAY3CQ==
X-Received: by 2002:a05:622a:a28a:b0:4b6:cbd:8c91 with SMTP id
 d75a77b69052e-4eb732d4f46mr80003351cf.5.1761227228971; 
 Thu, 23 Oct 2025 06:47:08 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4eb8080ca61sm14267651cf.21.2025.10.23.06.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 06:47:07 -0700 (PDT)
Date: Thu, 23 Oct 2025 09:47:05 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Gao Chao <chao.gao@intel.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>
Subject: Re: [PATCH v2 1/2] ram-block-attributes: Avoid the overkill of
 shared memory with hugetlbfs backend
Message-ID: <aPox2bGvDplUdPFe@x1.local>
References: <20251023095526.48365-1-chenyi.qiang@intel.com>
 <20251023095526.48365-2-chenyi.qiang@intel.com>
 <3035c1a0-78b7-44a4-a9d8-4e84b9732262@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3035c1a0-78b7-44a4-a9d8-4e84b9732262@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 23, 2025 at 12:16:46PM +0200, David Hildenbrand wrote:
> On 23.10.25 11:55, Chenyi Qiang wrote:
> 
> Subject should probably rather be:
> 
> "ram-block-attributes: fix interaction with hugetlb memory backends"
> 
> Maybe that can be fixed up when applying.

I also agree the old subject is slightly confusing..

I queued the two patches with all the small fixups.

Thanks,

> 
> > Currently, CoCo VMs can perform conversion at the base page granularity,
> > which is the granularity that has to be tracked. In relevant setups, the
> > target page size is assumed to be equal to the host page size, thus
> > fixing the block size to the host page size.
> > 
> > However, since private memory and shared memory have different backend
> > at present, users can specify shared memory with a hugetlbfs backend
> > while private memory with guest_memfd backend only supports 4K page
> > size. In this scenario, ram_block->page_size is different from the host
> > page size which will trigger an assertion when retrieving the block
> > size.
> > 
> > To address this, return the host page size directly to relax the
> > restriction. This changes fixes a regression of using hugetlbfs backend
> > for shared memory within CoCo VMs, with or without VFIO devices' presence.
> > 
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Tested-by: Farrah Chen <farrah.chen@intel.com>
> > Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> > ---
> 
> 
> -- 
> Cheers
> 
> David / dhildenb
> 

-- 
Peter Xu


