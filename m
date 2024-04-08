Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F31CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 01:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtdpg-0002tT-Hx; Sun, 07 Apr 2024 21:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rtdpd-0002t6-RH
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 21:29:58 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rtdpb-0007OK-Mz
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 21:29:57 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5e4f79007ffso2683133a12.2
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 18:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712539793; x=1713144593;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s8tM99cCNV90Hz0YFfr2YhADfBMOVgNclOcHIywGQSM=;
 b=vGibfDHrgjTN1RV0tfch+X4k51R4cDpM+dHG/iC0hYuZYOEMbLs0+VHUY1YuBhkKtB
 Ut05IRhIsLkN54fsY+E47G2Y/86exBgRzXdz9FD6SvSg2enviw8FK/797R7GWnVMKNPj
 VJgY0pjtgHwsNS3l12yiCQnGdCTbmBejukyNyDLb68i67cFr7bUVDjJsQk9C/Y389rTt
 YtJw6Tc0Jtw2kSLJiYl13fY8Ii4HiAOCr/qW7WrHtInDxxjoIgpYo8WVQwvNVF2as9Al
 LudGJQMYurV/pPJppXmTiIah2WIVs20kMk2/Yr8fjI6zztvFRiFaAMvs0kibPxo9BMsU
 /bRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712539793; x=1713144593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s8tM99cCNV90Hz0YFfr2YhADfBMOVgNclOcHIywGQSM=;
 b=nKOn1KmsF4J+StXvuy34OAOnpsknVoeUTClw0dGBEfiaMwtsmmx8XRys78RjQaMfxO
 4H+5Xpzy4RAsQJf3GfgtBwyroAwvwNquw0Jp+hFfrrckorkHwQMWxXqok+jGGdvqQQgz
 MFFpMQ7iE0abNgRNJe+hdaQ2BDwehhXo+OTpftC9z3v50VG3qjapD4/nKMKbFPnbycI6
 LP6vOmf+3j0OxLYSUJHeOnOf541t0DQA1iye3/7HRWVVGwAAEEWbNaZKu6FichNkIjBI
 PD6iIa9KInYklg+H/3H8FRsHSqb8Ond/bOIWGO+aSomHlgp0t143v6c03FA+JTA8K5kK
 A2IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7aTNgFoAXj3GUNOtMGBO9MuTVuc0rqhIL2LXT/HX4c0Qc3rlLD43Ye1DbB+K9t6GLy4YWd51ChGfP+yIGGu/CiU3ry5o=
X-Gm-Message-State: AOJu0YyG7pinfzpW9vGH4EFhwN1UGD1afGelN36gRkLSKU+pOI9HXvTv
 4Bd4Oq0pCThCNtcwT2dPlUcLZIMNPw7o4nWtFQCPirnkU/YSczxNAoHaJ3Fwy48=
X-Google-Smtp-Source: AGHT+IHNUHKCdeZhmtcsOsznETc7UJd76KfhLdTlEdYNH8IYJ26OLVsPXVAgnxmNwOTr0pnX1n9qog==
X-Received: by 2002:a05:6a21:3d86:b0:1a3:df2f:ab7 with SMTP id
 bj6-20020a056a213d8600b001a3df2f0ab7mr8487989pzc.24.1712539793396; 
 Sun, 07 Apr 2024 18:29:53 -0700 (PDT)
Received: from [157.82.200.213] ([157.82.200.213])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a631205000000b005cf450e91d2sm5000207pgl.52.2024.04.07.18.29.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Apr 2024 18:29:53 -0700 (PDT)
Message-ID: <60ad2ff3-ad95-49b8-8d6c-32bdcddde899@daynix.com>
Date: Mon, 8 Apr 2024 10:29:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/20] virtio-net: Return an error when vhost cannot
 enable RSS
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
 <20240403-rss-v9-13-c6d87e69d38b@daynix.com>
 <CAOEp5OdKAsUoJnLMXTM3RxbPT3c9Sob-7QRexCSqMNX10Enoug@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAOEp5OdKAsUoJnLMXTM3RxbPT3c9Sob-7QRexCSqMNX10Enoug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/04/08 6:46, Yuri Benditovich wrote:
> On Wed, Apr 3, 2024 at 2:11 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> vhost requires eBPF for RSS. When eBPF is not available, virtio-net
>> implicitly disables RSS even if the user explicitly requests it. Return
>> an error instead of implicitly disabling RSS if RSS is requested but not
>> available.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/net/virtio-net.c | 97 ++++++++++++++++++++++++++---------------------------
>>   1 file changed, 48 insertions(+), 49 deletions(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 61b49e335dea..3d53eba88cfc 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -793,9 +793,6 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
>>           return features;
>>       }
>>
>> -    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
>> -        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
>> -    }
>>       features = vhost_net_get_features(get_vhost_net(nc->peer), features);
>>       vdev->backend_features = features;
>>
>> @@ -3591,6 +3588,50 @@ static bool failover_hide_primary_device(DeviceListener *listener,
>>       return qatomic_read(&n->failover_primary_hidden);
>>   }
>>
>> +static void virtio_net_device_unrealize(DeviceState *dev)
>> +{
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> +    VirtIONet *n = VIRTIO_NET(dev);
>> +    int i, max_queue_pairs;
>> +
>> +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
>> +        virtio_net_unload_ebpf(n);
>> +    }
>> +
>> +    /* This will stop vhost backend if appropriate. */
>> +    virtio_net_set_status(vdev, 0);
>> +
>> +    g_free(n->netclient_name);
>> +    n->netclient_name = NULL;
>> +    g_free(n->netclient_type);
>> +    n->netclient_type = NULL;
>> +
>> +    g_free(n->mac_table.macs);
>> +    g_free(n->vlans);
>> +
>> +    if (n->failover) {
>> +        qobject_unref(n->primary_opts);
>> +        device_listener_unregister(&n->primary_listener);
>> +        migration_remove_notifier(&n->migration_state);
>> +    } else {
>> +        assert(n->primary_opts == NULL);
>> +    }
>> +
>> +    max_queue_pairs = n->multiqueue ? n->max_queue_pairs : 1;
>> +    for (i = 0; i < max_queue_pairs; i++) {
>> +        virtio_net_del_queue(n, i);
>> +    }
>> +    /* delete also control vq */
>> +    virtio_del_queue(vdev, max_queue_pairs * 2);
>> +    qemu_announce_timer_del(&n->announce_timer, false);
>> +    g_free(n->vqs);
>> +    qemu_del_nic(n->nic);
>> +    virtio_net_rsc_cleanup(n);
>> +    g_free(n->rss_data.indirections_table);
>> +    net_rx_pkt_uninit(n->rx_pkt);
>> +    virtio_cleanup(vdev);
>> +}
>> +
>>   static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>>   {
>>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> @@ -3760,53 +3801,11 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>>
>>       net_rx_pkt_init(&n->rx_pkt);
>>
>> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
>> -        virtio_net_load_ebpf(n);
>> -    }
>> -}
>> -
>> -static void virtio_net_device_unrealize(DeviceState *dev)
>> -{
>> -    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> -    VirtIONet *n = VIRTIO_NET(dev);
>> -    int i, max_queue_pairs;
>> -
>> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
>> -        virtio_net_unload_ebpf(n);
>> +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&
> 
> I disagree with this change of qemu behavior.
>  From my point of view:
> - this is not a major problem and it should not be a reason to stop VM execution
> - it is enough to disable the RSS feature and continue working. Depending on
>    other qemu parameters (number of queues, number of cpus) this might be just
>    suboptimal. might be a minor problem and might be not a problem at all

The reasoning is that we shouldn't disable what the user explicitly 
requested. c.f., 
https://lore.kernel.org/all/20231102091717-mutt-send-email-mst@kernel.org/

> - this change defines rss as _only_ feature whose absence breaks the VM start,
>    _all_ other features are dropped silently and only rss is not. Why??

I'm following what QEMU does in the other places rather than what it 
does just in virtio-net. I have pointed out virtio-gpu raises errors in 
such a situation. c.f., 
https://lore.kernel.org/all/8880b6f9-f556-46f7-a191-eeec0fe208b0@daynix.com

> - the series has a title 'Fixes and improvements' . This is not a fix and not an
>    improvement, this is significant behavioral change that should be discussed in
>    light of future plans regarding rss
> - I suggest to remove this change from the series, submit it separately
>    and discuss from all the sides

We should have already discussed about these matters; I responded all 
past replies in the previous versions months ago and had no update after 
that. Let's focus on matters that were not previously pointed out.

Regards,
Akihiko Odaki

