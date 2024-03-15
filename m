Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556C8C54E66
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 06:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl0sE-0005lt-26; Fri, 15 Mar 2024 02:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rl0s7-0005iN-Rm
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 02:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rl0s2-00012e-ME
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 02:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710483405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oNGC77qdZiukECanTKNkHyutURoiisCTg3MxGa1QMQo=;
 b=OzpNH+328o4K5Asg2iuiAOP8VmaX1hXT1PgUfnMGy52nZdTH7wB/ZjwSxfHTwxflEfw8ry
 0tE/BjVTzTFrmY2OlpeIk/pv4m2Q/ho18QvnQ9HLP4g90dwWGua3Bz3GeInNaAyI9NhkZV
 u2d92iL+oYFpIQuaspu91G36sZVAhPM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-pN2G1yRFO_uc6OG0B2mo6g-1; Fri, 15 Mar 2024 02:16:43 -0400
X-MC-Unique: pN2G1yRFO_uc6OG0B2mo6g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4140225e68aso622405e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 23:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710483402; x=1711088202;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oNGC77qdZiukECanTKNkHyutURoiisCTg3MxGa1QMQo=;
 b=vm5I9QVZdfXTVVHjph1mEdHnegZbTA53m2anhBZkKvdnzS08diAdkeWxAzOf9+UnWS
 NvxuGH3k48VRgR8iGneNqESsFUSLtpH654XTmB6Xq4nqZ3F3VNQDAuXcylzqqzj1F9By
 d61WIriuSnPej9IDiPvoSI4xHBjktwj8r5HibyKdhruhuwKE1yyS4taGBZHPDLC6pGnT
 9ognvWMikvip/8KZmF4v+S9VVXxV6maOe6xNs3vfeoA2tKrA6m4ODKdNQ1h9hSoY6UZd
 pxMPHRw2ufsREZGnZnHaDLZCCaPzuIzFsbJAQnU06GRe3nhEEoPEeL3PCwkfKFuDN5nR
 IGvg==
X-Gm-Message-State: AOJu0YxZXyuiVGsb8cE31DrEEX7JhVrFENMF7YkX++zcD3OwXuVVTXA3
 NbEc5PVco9t4qWGmuWT4hM2g2EIJLkNYzfjpiIlgM/4gffGtn3tOPBQ9LliQi+uTnWWCNr4gWCs
 VLTJdoq35/gWE8/2FzRixJXfsucJ/u0eNXDgml5F6PS1HlvC4Lvpi
X-Received: by 2002:a05:600c:3c99:b0:413:fa31:b9f6 with SMTP id
 bg25-20020a05600c3c9900b00413fa31b9f6mr1928985wmb.2.1710483402735; 
 Thu, 14 Mar 2024 23:16:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3UV5XzFTIndlSydklU85vW2pU3ehJvsaS7RQK5h46RWfDVqMf0Zj83h2UYvEyzrfgSce5eA==
X-Received: by 2002:a05:600c:3c99:b0:413:fa31:b9f6 with SMTP id
 bg25-20020a05600c3c9900b00413fa31b9f6mr1928970wmb.2.1710483402378; 
 Thu, 14 Mar 2024 23:16:42 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-176-251.web.vodafone.de.
 [109.43.176.251]) by smtp.gmail.com with ESMTPSA id
 o38-20020a05600c512600b00412cbe4f41bsm7962776wms.4.2024.03.14.23.16.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 23:16:42 -0700 (PDT)
Message-ID: <9fa4a11b-88b7-4959-bd98-4c5b65e11026@redhat.com>
Date: Fri, 15 Mar 2024 07:16:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/s390: clarify even more that cpu-topology is KVM-only
Content-Language: en-US
To: Claudio Fontana <cfontana@suse.de>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240314172218.16478-1-cfontana@suse.de>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240314172218.16478-1-cfontana@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 14/03/2024 18.22, Claudio Fontana wrote:
> At least for now cpu-topology is implemented only for KVM.
> 
> We already say this, but this tries to be more explicit,
> and also show it in the examples.
> 
> This adds a new reference in the introduction that we can point to,
> whenever we need to reference accelerators and how to select them.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>   docs/system/introduction.rst       |  2 ++
>   docs/system/s390x/cpu-topology.rst | 14 ++++++++------
>   2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
> index 51ac132d6c..746707eb00 100644
> --- a/docs/system/introduction.rst
> +++ b/docs/system/introduction.rst
> @@ -1,6 +1,8 @@
>   Introduction
>   ============
>   
> +.. _Accelerators:
> +
>   Virtualisation Accelerators
>   ---------------------------
>   
> diff --git a/docs/system/s390x/cpu-topology.rst b/docs/system/s390x/cpu-topology.rst
> index 5133fdc362..ca344e273c 100644
> --- a/docs/system/s390x/cpu-topology.rst
> +++ b/docs/system/s390x/cpu-topology.rst
> @@ -25,17 +25,19 @@ monitor polarization changes, see ``docs/devel/s390-cpu-topology.rst``.
>   Prerequisites
>   -------------
>   
> -To use the CPU topology, you need to run with KVM on a s390x host that
> -uses the Linux kernel v6.0 or newer (which provide the so-called
> +To use the CPU topology, you currently need to choose the KVM accelerator.
> +See :ref:`Accelerators` for more details about accelerators and how to select them.
> +
> +The s390x host needs to use a Linux kernel v6.0 or newer (which provides the so-called
>   ``KVM_CAP_S390_CPU_TOPOLOGY`` capability that allows QEMU to signal the
>   CPU topology facility via the so-called STFLE bit 11 to the VM).
>   
>   Enabling CPU topology
>   ---------------------
>   
> -Currently, CPU topology is only enabled in the host model by default.
> +Currently, CPU topology is enabled by default only in the "host" cpu model.

Thanks for your patch! I'd maybe write "cpu" with capital letters here like 
it is done in the other spots in this file. I can change that while picking 
up the patch.

  Thomas


