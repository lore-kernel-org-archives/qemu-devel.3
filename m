Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1522CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyHl-0006qO-MC; Mon, 01 Sep 2025 02:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1usyHj-0006pr-RX
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:45:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1usyHf-0002By-U3
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756709091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZAeKgrhGheU52UkHvBt4MN/ZQsgg8660kaAcqHQdr8=;
 b=FPTcLMhfHG4Av9+fuHWtRMw7gSJB9/i3IfjTksEHDTiNVcgepddFeKjj7EwKfVloKJeJq6
 L5/uZ/JRCMrktJy94rU0q9quRu2+ar7SDAnXIUcgNR1DhiugAH2vocSgj7rNkffuz1ADij
 tzcecc3VnUTrdqyitFFQjE9bnMk5kPA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-dLwGFSFjN7-M4126a2sEkA-1; Mon, 01 Sep 2025 02:44:50 -0400
X-MC-Unique: dLwGFSFjN7-M4126a2sEkA-1
X-Mimecast-MFC-AGG-ID: dLwGFSFjN7-M4126a2sEkA_1756709090
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7e870317642so831327785a.0
 for <qemu-devel@nongnu.org>; Sun, 31 Aug 2025 23:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756709090; x=1757313890;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LZAeKgrhGheU52UkHvBt4MN/ZQsgg8660kaAcqHQdr8=;
 b=OHbGKn3ltLmB7fIan17K452nQo6PgqjHWLRd0xph3gyCYlOBdf+XRT7EakWs1M26XZ
 EvriqKhboLaWR7HUXZHt+Vzs/jt6vvl+Xt7RYoHlF31z0KOic2vfBPzDlThh1/hzDouv
 +Mi0oIRrrzucESgWvq4ELuefACaXKUyY5342+Seo3Rpt8RdvCTLkym11e/EJccwu03g2
 hlcguo2l949ziqUn/yp9LktBkYnWu71NyqhYe1qa09UporB/Wde1oQmwOoojQxYYjqmy
 C+Wye6gj1pu9fZQCyWPdcO0d8LkL/jqvRkesMwRY5+wFOQjEokVFdn4UpZYDHp19UcWT
 ZvoA==
X-Gm-Message-State: AOJu0YwVH9xL7tV5qkN7KwxEHBEgFjL0g1Hgubf9WNE0RwE2Xx1BEH9p
 xEdbNOM0rgH9odqY7ErRc4KOEZPX517fkP3l2+xKg139smWT/AJedcvxauU9NTzPj2yIqc55Pns
 qay0tamHh6qQpFVbKCMeUXbESYCWfvvbgJRSVEFVntTk+FTkOlSLX1QRx
X-Gm-Gg: ASbGncuMCpxGViYBxxThWSNX3njQmtfoz2xNXmDEZmsR2tr2UFjX7noM9QNB4EeezKo
 zPiYYx2LT7+r5TkmOugDHIMQoe2ckICs6AzaPfmiFaWLR2PKZ96vIuyBi+rdApoj4pFhKJEuGxF
 V5154Ym0jYXZaRs1OncIDFOCkYeRcQKemC1nJ3LGegWBYzprDzuPjeEzHAVBwRNSElQZ3oBbBQT
 nLPSsuTZo/k7PKHnwCRhDx19nRcHlVnSPONmAhUR2yQeDZ1BiPWpINeqPytedcC/VnbGM3o/O6X
 ZPFd+QWrAHOVzq2gEQxCmTh3nNGiG2L9uf55H5ZUQP6rMGhb1Q7bt7rYWNSkpX/1MtFdz59QuTM
 wjiCUKfU9ZSo=
X-Received: by 2002:a05:620a:29c7:b0:804:d08e:fa34 with SMTP id
 af79cd13be357-804d08eff9emr51072885a.68.1756709089999; 
 Sun, 31 Aug 2025 23:44:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHefqSNFC5bIbrtUel0jkwvpRWX3NdmgxjxSG14CFX52wYdPX2FXMVRS1O9PGRISE6t+IJElg==
X-Received: by 2002:a05:620a:29c7:b0:804:d08e:fa34 with SMTP id
 af79cd13be357-804d08eff9emr51070785a.68.1756709089496; 
 Sun, 31 Aug 2025 23:44:49 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b30b671636sm58951681cf.31.2025.08.31.23.44.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Aug 2025 23:44:49 -0700 (PDT)
Message-ID: <8c41ea67-c5a3-4f16-85a2-cc4876f09995@redhat.com>
Date: Mon, 1 Sep 2025 08:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/13] virtio: introduce support for GSO over UDP tunnel
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <cover.1755080613.git.pabeni@redhat.com>
 <3590d748-752c-40f5-92c9-5c065dcc3c0b@rsg.ci.i.u-tokyo.ac.jp>
 <CACGkMEvOmgGyqv5-FGDAgyDrY9TpssEDtpNp07ro2oamg_7r1w@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEvOmgGyqv5-FGDAgyDrY9TpssEDtpNp07ro2oamg_7r1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 9/1/25 4:47 AM, Jason Wang wrote:
> On Thu, Aug 28, 2025 at 9:47 AM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2025/08/13 19:28, Paolo Abeni wrote:
>>> Some virtualized deployments use UDP tunnel pervasively and are impacted
>>> negatively by the lack of GSO support for such kind of traffic in the
>>> virtual NIC driver.
>>>
>>> The virtio_net specification recently introduced support for GSO over
>>> UDP tunnel, and the kernel side of the implementation has been merged
>>> into the net-next tree; this series updates the virtio implementation to
>>> support such a feature.
>>>
>>> Currently the qemu virtio support limits the feature space to 64 bits,
>>> while the virtio specification allows for a larger number of features.
>>> Specifically the GSO-over-UDP-tunnel-related virtio features use bits
>>> 65-69; the larger part of this series (patches 4-12) actually deals with
>>> extending the features space.
>>>
>>> The extended features are carried by fixed size uint64_t arrays,
>>> bringing the current maximum features number to 128.
>>>
>>> The patches use some syntactic sugar to try to minimize the otherwise
>>> very large code churn. Specifically the extended features are boundled
>>> in an union with 'legacy' features definition, allowing no changes in
>>> the virtio devices not needing the extended features set.
>>>
>>> The actual offload implementation is in patches 13 and 14 and boils down
>>> to propagating the new offload to the tun devices and the vhost backend.
>>>
>>> Patch 1 is a small pre-req refactor that ideally could enter the
>>> tree separately; it's presented here in the same series to help
>>> reviewers more easily getting the full picture, patch 2 updates to
>>> linux headers update script to deal with annotations recently introduce
>>> in the kernel and patch 3 is a needed linux headers update.
>>>
>>> Tested with basic stream transfer with all the possible permutations of
>>> host kernel/qemu/guest kernel with/without GSO over UDP tunnel support,
>>> vs snapshots creation and restore and vs migration.
>>>
>>> The new features are disabled by default to avoid compatibilty issues.
>>> They could be enabled after that hw_compat_10_1 will be added, together
>>> with the related compatiblity entries.
>>>
>>> Based-on: 9d71108d7de139dd4f4e6efe6837cabb32bf5616.1755078918.git.pabeni@redhat.com
>>
>> Now everything looks good to me. For the whole series:
>>
>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>
>> Regards,
>> Akihiko Odaki
>>
> 
> Acked-by: Jason Wang <jasowang@redhat.com>

Thank you for the feedback. I guess this series will go through
Micheal's tree, am I correct?

Also I suspect/fear it could need rebasing due to some other patches
being applied meanwhile, please LMK if a repost is needed, thanks!

Paolo


