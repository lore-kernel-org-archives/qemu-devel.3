Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E894FC47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 07:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTGbI-0000N1-A7; Fri, 26 Jan 2024 02:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rTGbG-0000MS-8X
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 02:26:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rTGbC-0007G1-B7
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 02:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706253961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F14fSzycygHoxFC2HupsADrn4ELZfHrk4ldIr6Y11E0=;
 b=HFyAzUp5t1IFkn6VRtRO67kioM8ixUzUI296FJLjiHWUwVAXz0UE/2VdwxG2/nTw40Ykni
 NPfHqHPSmAb7C4QIaRU8irdPvtrcB4rXC0ZmZgb3yWQiu6nzmj5o5dyEZMKmQPaCKk/Zku
 doM++gxcfXGu9zBQHafPJ3FC+n1N/kc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-tdx1f1OvOxiaQx8Sh-t-HQ-1; Fri, 26 Jan 2024 02:25:59 -0500
X-MC-Unique: tdx1f1OvOxiaQx8Sh-t-HQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-42987be5d14so1295851cf.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 23:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706253958; x=1706858758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F14fSzycygHoxFC2HupsADrn4ELZfHrk4ldIr6Y11E0=;
 b=vxPbC1wJhZDEG6BIwNim3kPfCoYd/cSHplOw/Gu2CEFDA1WRje5XqMR1YBCNKhcyoL
 PWTDr3zePgEdXzBLZFOuHJfKVpNVbCgGhTcel89RXP29h7Bj3c+o6eCxfku6yjfxoxaX
 39WhOV2fnYhf0KlmgYtY1IoFwubelM0swRcqijoTZZv5UVlvDgFuWtayCRuAA6nIcfpf
 ccsC4038ZxSlmCt0WWeNGGq3/GEIU04xEACyR/7rSCSVs5sQQENMBEw9z+TYKi9oWxov
 5u6IXv2sAbTaoEBv6S8FCPok+5ekXFsKeEh0seOzOmWNiduNtYMXcgmBxGkCqW58W4Kp
 CfQw==
X-Gm-Message-State: AOJu0Yy59AgE7oGpag3FeAcKBf+ZW1ehZI/n8UIE+Ll65ykICMkFDrfq
 PRFMfqc47+GHKj7jITRfOUSEn1pBtgGx1Mm4d+W6NMdYngBsbGJzW/Sw9dompKlzhWn4HAfQAVg
 rc+XVFVOEgLol70h+8Qn7YmtSBRTqVQR/sIyDI9RARoAh2BIJyOYp7QPJ8usFa5wY2gvOmJNg8G
 Rl2VFapn1zzqX4lZ5Gm5MzI+dgp3X8Uw==
X-Received: by 2002:a05:622a:1a03:b0:42a:435e:b66f with SMTP id
 f3-20020a05622a1a0300b0042a435eb66fmr1223743qtb.101.1706253958378; 
 Thu, 25 Jan 2024 23:25:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTQKWWhz68oBhy4ofhvDmiTxy+NrBs89zD0359HWsXGma5CjoV6hObKv8uKHKKudh0odsTcA==
X-Received: by 2002:a05:622a:1a03:b0:42a:435e:b66f with SMTP id
 f3-20020a05622a1a0300b0042a435eb66fmr1223733qtb.101.1706253958123; 
 Thu, 25 Jan 2024 23:25:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 bb36-20020a05622a1b2400b0042a7e522e97sm195704qtb.73.2024.01.25.23.25.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 23:25:57 -0800 (PST)
Message-ID: <321648aa-e0e8-4223-ab12-c0b5940ddd5a@redhat.com>
Date: Fri, 26 Jan 2024 08:25:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Clear MSI-X IRQ index always
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jing Liu <jing2.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240125144220.770725-1-clg@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240125144220.770725-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/25/24 15:42, Cédric Le Goater wrote:
> When doing device assignment of a physical device, MSI-X can be
> enabled with no vectors enabled and this sets the IRQ index to
> VFIO_PCI_MSIX_IRQ_INDEX. However, when MSI-X is disabled, the IRQ
> index is left untouched if no vectors are in use. Then, when INTx
> is enabled, the IRQ index value is considered incompatible (set to
> MSI-X) and VFIO_DEVICE_SET_IRQS fails. QEMU complains with :
> 
> qemu-system-x86_64: vfio 0000:08:00.0: Failed to set up TRIGGER eventfd signaling for interrupt INTX-0: VFIO_DEVICE_SET_IRQS failure: Invalid argument
> 
> To avoid that, unconditionaly clear the IRQ index when MSI-X is
> disabled.


Applied to vfio-next.

Thanks,

C.





