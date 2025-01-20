Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69935C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 00:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZfkj-0006qI-TP; Sun, 19 Jan 2025 19:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tZfkf-0006q3-Gq
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 19:34:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tZfkd-000471-Ry
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 19:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737333286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bRHiqA+Tg4XuUV7fQjItzR8Q7urlqtioweKD4uQAS6s=;
 b=ILofYmWFuqN+tlfmSzoe+gxa6bDil/FIJi7Ul4rwZ/6DSlenigPuy7AUn/D02TsrWN2j94
 PyKWuulk2smjO2rDueHtAY9nzH4phLb+LUbax+7RsakG/qA7lLGuNMmnHBJ7LYvP6PbiNy
 ClMBKRbxe5BbftfdUnMcDt+aD/Wc5NM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-AsKeNjUbNBi6aorYiRyW0w-1; Sun, 19 Jan 2025 19:34:44 -0500
X-MC-Unique: AsKeNjUbNBi6aorYiRyW0w-1
X-Mimecast-MFC-AGG-ID: AsKeNjUbNBi6aorYiRyW0w
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-216750b679eso52639625ad.1
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2025 16:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737333283; x=1737938083;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bRHiqA+Tg4XuUV7fQjItzR8Q7urlqtioweKD4uQAS6s=;
 b=h5+72ddJMyw0HNGQ5uW7XlB6Ak6ldblDEYTp7wKE9qmrgq3RkqFEL2xE9xsmx8CuJ+
 YI7ZV92mLehjEHDHKlmjqKORwaLI0y9MYPa9P3EvBFfiG6owu7/5qgerKib8ZgBxvJfp
 pMtxjnaCFsR+pW2ntfucjOi1Ah6xK79d+BdwGt/kCoDufRz4nJSPkC7Yf1BdVpCRGuJY
 qSX3LwMWWc7/4hgOEcu3iWGTgRrbolUIh8VAlaH6duP8YgHw2zm9Mt0oMNMMsig64SkS
 gPJVISU4bGz6xcT03qaQEDO98X7JmewvpUJt5jSFAl6pc+/a1nSzfSwAFtD2JNXOrIqN
 kykQ==
X-Gm-Message-State: AOJu0Yxa8ylgbkBKJ2GzqlL+nxG5t9zltlMTJl4LmaUlDVkKYSq3ZLc7
 MLznwlGLH10WMiGE7hbMOL8Ig45UFe4ZpFCI3gegYVPUTEPgboZpfec/4phmLRZHLcYzRRfpOeC
 VJN4V22u+A4APZiqahuMu+VwLP4HgMn5hPXnnPZK9oVUOcPW0biumGRKbb18zOeIhA4xDMN5cP4
 fhoGsqPHIpIbfQTCcCDXizjPauuhbt/4WJw8HfUA==
X-Gm-Gg: ASbGncsQ8S5x+jWGRJNsyN+XuUQ0s+n6Talndk6VWS5UVXSk2CvDSFGyUpC1GFoR4hM
 +t7bAXGItFV9Dke3cHvFGGXfEnj97gtATAQ8UHIJeBcez8ElXs8O4
X-Received: by 2002:a05:6a20:3d86:b0:1e0:9cc2:84b1 with SMTP id
 adf61e73a8af0-1eb2158d07amr19054641637.30.1737333283313; 
 Sun, 19 Jan 2025 16:34:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmtYmfSdqflvyiEMLDE1TkUDrWmzM73y7b4/rPYAO5+6Aujmr8IZ9C7hdThn4fLkTNbE52PyB62jH3j9VpGxs=
X-Received: by 2002:a05:6a20:3d86:b0:1e0:9cc2:84b1 with SMTP id
 adf61e73a8af0-1eb2158d07amr19054610637.30.1737333282864; Sun, 19 Jan 2025
 16:34:42 -0800 (PST)
MIME-Version: 1.0
References: <20250117111709.970789-1-lvivier@redhat.com>
 <20250117111709.970789-3-lvivier@redhat.com>
In-Reply-To: <20250117111709.970789-3-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Jan 2025 08:34:30 +0800
X-Gm-Features: AbW1kvbentXiW8c0BJzXAGdYUoAkgWh0HNJ7KWYP-H0S5vBD3AyI8wCrLrtcpL8
Message-ID: <CACGkMEsMEddt_-4Yj3xGbPRF-OcU87C6J9P8qehMoXsKEZzO8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] net/dump: Correctly compute Ethernet packet offset
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 17, 2025 at 7:17=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:
>
> When a packet is sent with QEMU_NET_PACKET_FLAG_RAW by QEMU it
> never includes virtio-net header even if qemu_get_vnet_hdr_len()
> is not 0, and filter-dump is not managing this case.
>
> The only user of QEMU_NET_PACKET_FLAG_RAW is announce_self,
> we can show the problem using it and tcpddump:
>
> - QEMU parameters:
>
>   .. -monitor stdio \
>      -netdev bridge,id=3Dnetdev0,br=3Dvirbr0 \
>      -device virtio-net,mac=3D9a:2b:2c:2d:2e:2f,netdev=3Dnetdev0 \
>      -object filter-dump,netdev=3Dnetdev0,file=3Dlog.pcap,id=3Dpcap0
>
> - HMP command:
>
>   (qemu) announce_self
>
> - TCP dump:
>
>   $ tcpdump -nxr log.pcap
>
>   without the fix:
>
>     08:00:06:04:00:03 > 2e:2f:80:35:00:01, ethertype Unknown (0x9a2b), le=
ngth 50:
>          0x0000:  2c2d 2e2f 0000 0000 9a2b 2c2d 2e2f 0000
>          0x0010:  0000 0000 0000 0000 0000 0000 0000 0000
>          0x0020:  0000 0000
>
>   with the fix:
>
>     ARP, Reverse Request who-is 9a:2b:2c:2d:2e:2f tell 9a:2b:2c:2d:2e:2f,=
 length 46
>          0x0000:  0001 0800 0604 0003 9a2b 2c2d 2e2f 0000
>          0x0010:  0000 9a2b 2c2d 2e2f 0000 0000 0000 0000
>          0x0020:  0000 0000 0000 0000 0000 0000 0000
>
> Fixes: 481c52320a26 ("net: Strip virtio-net header when dumping")
> Cc: akihiko.odaki@daynix.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


