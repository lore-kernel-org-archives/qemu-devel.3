Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86312C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMA1-0008C6-CS; Wed, 13 Mar 2024 06:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rkM9u-00088y-9t
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:48:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rkM9o-0005my-1k
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710326902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=02Uy6I1pJ7IGclKC4/mdNq6Oq4ji/kvfYdxDrDXLtQM=;
 b=F2iH0dSXlSdvshPQKiVNUebof3v3qiK8yInzeBa1fWgLt9dzeSp4Ss/nX7MP6gC2z9cIcQ
 Goq/jvlulT8Suu928OJUjQ8fchOVdbBtATOlwSXXEEvj+P/nCpa643VmleQlSHvLlrbdJF
 d+fRa30VqSNEA43uYAxYBOl9NB/VjSw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-AWwzF7ljPraTAvUqBuAJ-A-1; Wed, 13 Mar 2024 06:48:21 -0400
X-MC-Unique: AWwzF7ljPraTAvUqBuAJ-A-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33e94548450so315932f8f.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710326900; x=1710931700;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=02Uy6I1pJ7IGclKC4/mdNq6Oq4ji/kvfYdxDrDXLtQM=;
 b=w6O0uu/I17uauGVso8Uj/pbirOKR/4J9SDVNY7wjmL4yng24g3UqRevmrGbsj1B602
 r6MPNvTpA2p/e6QRdsmrRHDfym1m3jlRDSuD8II8tDXmIyDMOnEsQFTFwJiIoc+SdpZ9
 hWmH6rZiL5XasvvFBJStIu0mwOfw6oVS4cUqmKnxZCkHyXE/vLycSo3f/fWFUYpXM9+h
 3JmGTSU5XbY3y3PD5SOSk6i0eAaURbOonqg6kY+mW8mzV0oWs+0sw18/sVqjNqOGno9X
 Hr68iRlej5M6I1BuAzU3M0u2AqDzGXlMwqQcD9/hfNVefqMkAgS3QsDvYrnrL0X1lsgK
 s8jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwxETF/c6fJoQsddAM4N/BLoXzfuKsJl/YMa9qqISOxDk/ymSRI8zUI8dmz+wjgYLO7iWtO+JaCzD195x+IRjnwqOQulU=
X-Gm-Message-State: AOJu0YwPgE9QGcw7mUH4c371UeoaI/bkaXGYIZwtMK4Cvs5LO5YRAcrK
 XF0T4rTwrsCfWNPF2eHWfIhvaQHy7H4pBZXOeYQdvX7qpdVc1oJl7tyZ94JRZZBVDWo5RmSM4td
 yt46O+5g0PWwqoXWkKZSgCHfmZOYd/ncgO4PAxxjVsIxnErA6h5N5
X-Received: by 2002:adf:a48e:0:b0:33e:929e:5366 with SMTP id
 g14-20020adfa48e000000b0033e929e5366mr1873958wrb.28.1710326900634; 
 Wed, 13 Mar 2024 03:48:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaVsJ5uKSy7dXq1VQCSUh92NqSs8aA/PYNVp9jcuB3iMBdJ/yLKlZpRnhd6jyJEUyjbuM4jw==
X-Received: by 2002:adf:a48e:0:b0:33e:929e:5366 with SMTP id
 g14-20020adfa48e000000b0033e929e5366mr1873941wrb.28.1710326900238; 
 Wed, 13 Mar 2024 03:48:20 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6046000000b0033e122a9a91sm11303230wrt.105.2024.03.13.03.48.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 03:48:19 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Mar 2024 11:48:19 +0100
Message-Id: <CZSKAAQ3HE0Q.32DYA8Y3PX16V@fedora>
Cc: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <qemu-devel@nongnu.org>,
 <vchundur@redhat.com>
Subject: Re: [PATCH v3 3/3] Add support for RAPL MSRs in KVM/Qemu
From: "Anthony Harivel" <aharivel@redhat.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
X-Mailer: aerc/0.15.2-111-g39195000e213
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-4-aharivel@redhat.com> <ZbjDtytv-_-Bz4-S@redhat.com>
 <CZRQCYCXNTF2.1I5CNECSOB6IL@fedora> <ZfB5eBwWXL45sN_K@redhat.com>
In-Reply-To: <ZfB5eBwWXL45sN_K@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Daniel,

Daniel P. Berrang=C3=A9, Mar 12, 2024 at 16:49:

> The point still stands though. NUMA node ID numbers are not
> guaranteed to be the same as socket ID numbers. Very often
> then will be the same (which makes it annoying to test as it
> is easy to not realize the difference), but we can't rely on
> that.
>
> > I'm using functions of libnuma to populate the maxpkgs of the host.=20
> > I tested this on different Intel CPU with multiple packages and this=20
> > has always returned the good number of packages. A false positive ?
>
> maxpkgs comes from vmsr_get_max_physical_package() which you're
> reading from sysfs, rather than libnuma.
>
> > So here I'm checking if the thread has run on the package number 'i'.=
=20
> > I populate 'numa_node_id' with numa_node_of_cpu().
> >=20
> > I did not wanted to reinvent the wheel and the only lib that was talkin=
g=20
> > about "node" was libnuma.
>
> I'm not actually convinced we need to use libnuma at all. IIUC, you're
> just trying to track all CPUs within the same physical socket (package).
> I don't think we need to care about NUMA nodes to do that tracking.
>

Alright, having a deeper look I'm actually using NUMA for 2 info:

- How many cpu per Package: this helps me calculate the ratio.

- To whom package the cpu belongs: to calculate the ratio with the right=20
  package energy counter.

Without libnuma, I'm bit confused on how to handle this.=20

Should I parse /sys/bus/node/devices/node* to know how many packages ?
Should I parse /sys/bus/node/devices/node0/cpu0/topology/core_cpus_list=20
to handle which cpu belongs to which package ?

Would that be too cumbusome for the user to enter the detail about how
many packages and how many cpu per pakages ?=20

i.e:=20
-kvm,rapl=3Dtrue,maxpkgs=3D2,cpupkgs=3D8,rapl-helper-socket=3D/path/sock.so=
ck

> > Maybe I'm wrong assuming that a "node" (defined as an area where all=20
> > memory has the same speed as seen from a particular CPU) could lead me=
=20
> > to the packages number ?
>
> Historically you could have multiple sockets in the same NUMA node
> ie a m:1 mapping.
>
> These days with AMD sockets, you can have 1 socket compromising
> many NUMA nodes, as individual dies within a socket are each their
> own NUMA node. So a 1:m mapping
>
> On Intel I think it is still typical to have 1 socket per numa
> node, but again I don't think we can rely on that 1:1 mapping.
>
> Fortunately I don't think it matters, since it looks like you
> don't really need to track NUMA nodes, only sockets (phnysical
> package IDs)
>

Very informative, thanks !

> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

Regards,
Anthony



