Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F268E63F3F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 17:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs2I6-000369-TI; Mon, 16 Feb 2026 12:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1vs2I2-00035j-FT
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 12:21:42 -0500
Received: from esa13.hc2706-39.iphmx.com ([216.71.137.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1vs2Hz-0001ZW-Iy
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 12:21:42 -0500
X-CSE-ConnectionGUID: bhyG8PuiT5GtE8UQiHNFuA==
X-CSE-MsgGUID: 6KqozgB9TKaNHQzjkXVswQ==
Authentication-Results: ob1.hc2706-39.iphmx.com;
 dkim=pass (signature verified) header.i=@bu.edu;
 spf=SoftFail smtp.mailfrom=alxndr@bu.edu;
 dmarc=pass (p=quarantine dis=none) d=bu.edu
X-IronPort-RemoteIP: 209.85.222.70
X-IronPort-MID: 112763627
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:ZdJy2KhBQZHZ40w59E7Y5GByX161NhEKZh0ujC45NGQN5FlHY01je
 htvXWjXa/uJYmenLt5/atyz8R4Eu5WHxtRlHQI9+yszFnsW8JqUDtmndXv9bniYRiHhoOOLz
 Cm8hv3odp1coqr0/0/1WlTZhSAik/nOGvykUbCs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpKrfjawP9TlK6q4m1A5AVgPa0jUGL2zBH5MrpOfcldEFOlGuG4LsbiL
 87fwbew+H/u/htFIruNjrbhf0QWdaXZNA6Ih2A+c/DKbs9q/3FaPg4TbZLwWG8O49m7t4kZJ
 OZl7PRcfTwU0pjkw4zxZfX6/xZWZsWq8JefSZS2XFf6I0fuKhMAyN03ZK060BFxFk+azgii+
 NRBQA3hYCxviMq8wKOUGtFxh/h+A9XGbL4mu1FG4yzwWKNOrZDrG80m5Pdd1TY0w91HRLPQO
 JJfZj1oYxDNJRZIPz/7CrpkxLbu1iS5KWcC7g3NzUY0yzG7IAhZ2bz9NtbPUtaXA8hZgy50o
 0qfpj6mXEpEboP3JTytrFG1gf3At3LHe4s0NISq9P1avkaM/zlGYPERfR7hyRWjsWanVtdCb
 kAZ5Ccqha418kOtU5/6RRLQnZKflhsVWt4VDuRjrQ/Skuzb5AGWAmVCRTlEADA7iPILqfUR/
 gbht/vjGHpivKD9dJ5X3u3Pxd9uEUD59VM/WBI=
IronPort-HdrOrdr: A9a23:OWP/8KCSSa+8TjLlHelA55DYdb4zR+YMi2TDiHocdfUFSKGlfp
 6V9sjzGyWE9gr5P0tQ6exoWZPwME80kKQb3WB/B8bYYOCLghrOEGgm1/qb/9SCIVyGygc+79
 YcT0EWMrSZZike/KLHCUuDYrAdKbK8gdyVbInlvghQZDAvRaUlwAtwFxqBHlcefng9ObMJUL
 SZouRIzgDBRZ3VVKWG77s+MdTrlpnsqK/MRyIgKloO1DSu5AnYm4IS2iLovWZ9bw9y
X-Talos-CUID: 9a23:0gwxqWNni1A/8u5DUil22x4sB8EZL1LB4SftGk6YL0h0YejA
X-Talos-MUID: 9a23:waBwKwnTuC6jRX6GPhuUdno8F95v8auEWXwumLMmgtuGNhxOICik2WE=
Received: from mail-ua1-f70.google.com ([209.85.222.70])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 16 Feb 2026 12:21:31 -0500
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-94accb6be34so6900880241.2
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 09:21:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771262490; cv=none;
 d=google.com; s=arc-20240605;
 b=Wi2/UnJPGNbOwZVd9PbgcP/pSBHoqjsAr7TXB2hhHmDfQ9mK5dEqYZjf78nmsjcD6K
 NJ9Ysp+hqVT75m7Zj7f9Thj4xgZQUI4fejvXNWpEpjnrfN0ZFqeXPZcJYm2WVD2E0hsY
 oz+5jsIqxQybHoZY3ln6sUPXeyoHLAr3OyYF08tu7xTrd4X2O8D98OxS1HXQv+l6aVyb
 /5ottQi4HPHLIqUMdshTfIbHxAlRXlEzLT3z7Ukr7qrf6xSAmoPNSPY3cgmiq8YZX2aq
 yyUJL5t4Qq/egYAI+KFm8QEo+3t4Li1s8bN/M1pkwzthhbHvvUJ8ayZg6lZbGAQHpXIU
 tt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:dkim-signature;
 bh=YAA03pNwKuj7XWLL3TCCeXedFzUnjGsKN8P+9PC846c=;
 fh=mfJ1tdpYMn1fhgEbLuN2RfzI9QsYECM+rWot5b4NL6o=;
 b=WInQB8V5ThfOO6ndcshAcT9wQth2dqJ0F0k/z406d6ev1az++O43tqUqU1u1Juipxm
 etX15Q973LSRJ8gnUUEXHD8NJgl6paQh1POYE02Z0EqnmI9rC9Wv4CP3vFB6e/oizCg1
 yqlvpImuDHJTA2BUIWZu34kZ5eE8mQQlamDSke+AdxZkuo2ekkO9Mo4/Z2Bv0H6CCeoT
 grwga0BNJTAzYBOmcmqC+XR1KJB6j76+RfcAnCnzKNFbiaLx61m06cef1PLEmP5tS7OR
 xUSQh212p8m9fVcRG+rjovY2/qssS9W9eRg//sXNrWiemVnXUHBVA8ryH7hNCbxdz2hQ
 9hfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1771262490; x=1771867290; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YAA03pNwKuj7XWLL3TCCeXedFzUnjGsKN8P+9PC846c=;
 b=XpycrX/c09Utey3DUlkAq3XVARDM0v5D8Ml7rU8ZoUJa6EAWCSabGjnRKsPUSb4mdV
 rybBnbICcPzYuTgUKqhosxY114pyGMMNP0Dkylyp0nCX602NO2BgfVl+b5h/f5vnyQYl
 mH/vqJgZEfVTsaZhpKj9N+WAeSK3/zDgu6vpMsWgKGkYBqpUHV+kciEszSIvPJgWHrWw
 5ZtTGb2D+W8OsLgSYyCJ/r1QJguPSfPcXrF7KZnL/wI+Yn4MVWS6mU0Kn46AqmlBzhKm
 9PERPevKkO2WpVG7ftzkMMKHpWnv1qdekOVaosNsJCda66tKEFyma0xzveW/SGzQjzsg
 5jGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771262490; x=1771867290;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YAA03pNwKuj7XWLL3TCCeXedFzUnjGsKN8P+9PC846c=;
 b=RmN6K8QvHr+TkZ+Zsy49TIwZhpGeWYdEN/JxogJlJSOxvNhkU/zF7PMVrg56z3rc0i
 IRPWwa5vynl0H50e4EGGReV1LIbI37kWXs6PUzDPIna1xFBsgJn0eWuJVPhXvTv3n3HT
 ICMz0nEVOqwVUx7D8rFl7EhC6HNa+tiVpK/Kzi5UEynzuDETtxOcfg0HR4uQA73xXTlb
 vf2IMRcz3Xttt9Wp6dLo6Q4XgutoNypJCuKODtV/gNV+hZRBy1t85lTY6gcPd4naJAnx
 emao6z9GV5klWE4zsp0x83Cg9b8sBf9hyJgY9nXWXPk08x79fGdmhBg2sNSJCGlPO4CA
 DX/A==
X-Gm-Message-State: AOJu0YxxHVg6O0xmSOX9hjRTpPs2XGoCuMIyHH78JtI8SnZ+Ia6wpr4S
 p4lPAG3zbbmL1rjJe5xZRlSlYIOYK3hLiaOylpYfkhE2OEy019UYEVrjmKVQLJa047swld9RZwq
 cz2A77I/udEkcL7ztcHGZMzloMbLK1rHJeb8Yd2NMrfaVUssybP6y9IJqZMeGCWqCjUa/cbAtYD
 E8sORgnQp8nQa82bn5koJUS/YO3SnlKxgF8jgC1DdV0X/G
X-Gm-Gg: AZuq6aL5Hjv8fKybFkJEFHWXS1MnM5m7ztUHDmxc5t2PSOM2j33NcfCTYjGzIYwjLad
 sKng0DpEnm1fdYmt3TzOnGPSK69Zv4ZAasNNS3hDrd7TI+XyQ9KmfUObp0LBz2BCEunaY4UBcnn
 BDKvy5C1VARXZI7xbqtpxNIV2ngakJEYV7AF33tqBWP8iAnx9uYl7dqjgzk/AOVCbueUHUjjB8q
 w8ZOaJnxIcAlmDm4RQaBdtfEyv5G/GY3EJ7cnUvF18M5K10cYDppwY3IDXN8PuH/rY=
X-Received: by 2002:a05:6102:3747:b0:5db:cba0:941 with SMTP id
 ada2fe7eead31-5fe2aff3b8dmr2707484137.38.1771262490175; 
 Mon, 16 Feb 2026 09:21:30 -0800 (PST)
X-Received: by 2002:a05:6102:3747:b0:5db:cba0:941 with SMTP id
 ada2fe7eead31-5fe2aff3b8dmr2707473137.38.1771262489703; Mon, 16 Feb 2026
 09:21:29 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Feb 2026 11:21:28 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Feb 2026 11:21:28 -0600
From: Alexander Bulekov <alxndr@bu.edu>
References: <20260212144244.22579-1-pbonzini@redhat.com>
 <20260212144244.22579-29-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20260212144244.22579-29-pbonzini@redhat.com>
Date: Mon, 16 Feb 2026 11:21:28 -0600
X-Gm-Features: AaiRm50v8So9WbEcg4aFApyu14ptgs68zidRgIx4npLQr9YLMLNLuPC8oC_Shuw
Message-ID: <CAHUE=o-TKQa-ttPBGt++kkT7CHyjyMR7-j7rJtr3YzB=-iHXvA@mail.gmail.com>
Subject: Re: [PULL 28/41] hw/char/virtio-serial: Do not expose the
 'emergency-write' property
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.71.137.83; envelope-from=alxndr@bu.edu;
 helo=esa13.hc2706-39.iphmx.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 260212 1542, Paolo Bonzini wrote:
> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> The VIRTIO_CONSOLE_F_EMERG_WRITE feature bit was only set
> in the hw_compat_2_7[] array, via the 'emergency-write=3Doff'
> property. We removed all machines using that array, lets remove
> that property. All instances have this feature bit set and
> it can not be disabled. VirtIOSerial::host_features mask is
> now unused, remove it.
>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Link: https://lore.kernel.org/r/20260108033051.777361-28-zhao1.liu@intel.=
com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Hello,
This change appears to have introduced a Heap-buffer-overflow:
https://gitlab.com/qemu-project/qemu/-/issues/3303
-Alex

> ---
>  include/hw/virtio/virtio-serial.h | 2 --
>  hw/char/virtio-serial-bus.c       | 9 +++------
>  2 files changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio=
-serial.h
> index 60641860bf8..da0c91e1a40 100644
> --- a/include/hw/virtio/virtio-serial.h
> +++ b/include/hw/virtio/virtio-serial.h
> @@ -186,8 +186,6 @@ struct VirtIOSerial {
>      struct VirtIOSerialPostLoad *post_load;
>
>      virtio_serial_conf serial;
> -
> -    uint64_t host_features;
>  };
>
>  /* Interface to the virtio-serial bus */
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index 5ec5f5313b2..b7c57ea9678 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -557,7 +557,7 @@ static uint64_t get_features(VirtIODevice *vdev, uint=
64_t features,
>
>      vser =3D VIRTIO_SERIAL(vdev);
>
> -    features |=3D vser->host_features;
> +    features |=3D BIT_ULL(VIRTIO_CONSOLE_F_EMERG_WRITE);
>      if (vser->bus.max_nr_ports > 1) {
>          virtio_add_feature(&features, VIRTIO_CONSOLE_F_MULTIPORT);
>      }
> @@ -587,8 +587,7 @@ static void set_config(VirtIODevice *vdev, const uint=
8_t *config_data)
>      VirtIOSerialPortClass *vsc;
>      uint8_t emerg_wr_lo;
>
> -    if (!virtio_has_feature(vser->host_features,
> -        VIRTIO_CONSOLE_F_EMERG_WRITE) || !config->emerg_wr) {
> +    if (!config->emerg_wr) {
>          return;
>      }
>
> @@ -1040,7 +1039,7 @@ static void virtio_serial_device_realize(DeviceStat=
e *dev, Error **errp)
>          return;
>      }
>
> -    if (!virtio_has_feature(vser->host_features,
> +    if (!virtio_has_feature(vdev->host_features,
>                              VIRTIO_CONSOLE_F_EMERG_WRITE)) {
>          config_size =3D offsetof(struct virtio_console_config, emerg_wr)=
;
>      }
> @@ -1156,8 +1155,6 @@ static const VMStateDescription vmstate_virtio_cons=
ole =3D {
>  static const Property virtio_serial_properties[] =3D {
>      DEFINE_PROP_UINT32("max_ports", VirtIOSerial, serial.max_virtserial_=
ports,
>                                                    31),
> -    DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_features,
> -                      VIRTIO_CONSOLE_F_EMERG_WRITE, true),
>  };
>
>  static void virtio_serial_class_init(ObjectClass *klass, const void *dat=
a)
> --
> 2.52.0
>
>

