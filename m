Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB69C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 08:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSvUB-00069u-QN; Thu, 25 Jan 2024 03:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rSvUA-00069m-2W
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 03:53:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rSvU8-00059k-Ej
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 03:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706172799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jrrZZowuMJJI6TZrYUVQRpQ+aMmEUFJtqUb9r2JH5ks=;
 b=M3Kb2GzUSNrdcIsiNWf+XZZ9JqMT31rlLuTDubzgXqFq9jvdsNA3Dg5iua+lzFHFjNpZu1
 i3yc4XEFG3ZfHHpoSG8FgGDHy3ucgA1hZLKXolovX3E5DPBIcKjJ7ozc7IW0GW/w2aAUyq
 gBtu72WZ+WrrFHAV+fcqrOqa4cnVY7o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-t2CFtXVgM6moNQk-qDKd4g-1; Thu, 25 Jan 2024 03:53:16 -0500
X-MC-Unique: t2CFtXVgM6moNQk-qDKd4g-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a2b6da35066so291839066b.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 00:53:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706172796; x=1706777596;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jrrZZowuMJJI6TZrYUVQRpQ+aMmEUFJtqUb9r2JH5ks=;
 b=WVQZeqdASxqnzh4ccUudt7z2gxU94+Tj3vOcfug3n9NwK4FFgpshY0Ok+3Yvwsnt7k
 w5fPniNQNErUIYx8NVAPDcYxMS2JtSBqSW9GQxQp/apdC9H6J4J/2MXA1PhIwMmByhvg
 3YCr0/K8IvSHyDQtcFsGMoiNB8TwkA3w1BtLdmgWTNlKtaEHo7pHwQZyuXUv7aATYpnl
 hDOr3xZmjNoezGsacaIpD7IH1Hzy6l0L8N5tROiRoqMu1fr+PIR1L07rIif5jfTtLvXn
 S1oOXxI90aRFXijftfMHtsNLhP01Up89TdauKoFK1KfGp3zbAPYXeVogEe5SPIg/r8sE
 1nSQ==
X-Gm-Message-State: AOJu0YxHcrglwx72vP7/8OR4B9RNMtETFX9/C1IYF/nkrfP3BtYyzG3t
 Fa0ORnfFffSXefQc6y/EHeIldFrWBxb2HWCxZmFS6492Fpn6zlmnxnxCCA2+b1D23xZ8wE65m/n
 0cz5A7yLu9dpAs58LZ3/3p/1Nv5Y6c6jfzuQ7ey41/S1Kg900c6op
X-Received: by 2002:a17:907:bb8f:b0:a29:3089:16c3 with SMTP id
 xo15-20020a170907bb8f00b00a29308916c3mr278557ejc.8.1706172795840; 
 Thu, 25 Jan 2024 00:53:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/uYw/T/B7F3ZRHP2z6CaH/vfEdmQUvYGAByRNa6XMUH2vovD4NChXDHlOoKc+mYQIKoBHkA==
X-Received: by 2002:a17:907:bb8f:b0:a29:3089:16c3 with SMTP id
 xo15-20020a170907bb8f00b00a29308916c3mr278549ejc.8.1706172795474; 
 Thu, 25 Jan 2024 00:53:15 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-119.web.vodafone.de.
 [109.43.176.119]) by smtp.gmail.com with ESMTPSA id
 lh14-20020a170906f8ce00b00a30e1f233b4sm778270ejb.128.2024.01.25.00.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 00:53:15 -0800 (PST)
Message-ID: <64cbc494-0379-494e-93b9-e7f6b140da09@redhat.com>
Date: Thu, 25 Jan 2024 09:53:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/88] esp: rework ESP emulation to use a SCSI phase-based
 state machine
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, hpoussin@reactos.org, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/01/2024 13.52, Mark Cave-Ayland wrote:
> The ESP SCSI chip fundamentally consists of a FIFO for transferring data to/from
> the SCSI bus along with a command sequencer which automates various processes such
> as selection, message/command transfer and data transfer. What makes this chip
> particularly interesting is that the FIFO is also used as a buffer for DMA transfers
> which makes it possible to mix and match DMA and non-DMA transfers when sending and
> receiving data to/from the SCSI bus.
> 
> Whilst the current ESP emulation works well for most cases, there are several
> problems that I've encountered whilst trying to debug various guest issues:
> 
> 
> 1) Multiple code paths for non-DMA, DMA and pDMA
> 
> Consider a SCSI request being submitted by the guest: if it is a DMA SCSI
> request then it takes one path through get_cmd(), and a different path through
> get_cmd() for pDMA. This then leads to the DMA code path being called for DMA
> and the pDMA codepath being called for each FIFO write. Finally once you add
> in the non-DMA path you end up with a total of 5 potential codepaths for any
> given SCSI request.
> 
> 2) Manual handling of STAT_TC flag
> 
> According to the datasheet the STAT_TC flag in ESP_RSTAT is set when the DMA
> transfer counter reaches zero. The current code handles this manually in
> multiple places, including where it shouldn't be necessary.
> 
> 3) Deferred interrupts are used only for reads and not writes
> 
> The ESP emulation currently makes use of a deferred interrupt when submitting
> read commands i.e. the interrupt flags are not updated immediately but when
> the QEMU SCSI layer indicates it is ready. This works well for reads, but isn't
> implemented for writes which can cause problems when the host is heavily loaded
> or a large SCSI write is requested.
> 
> 4) Padding of pDMA TI transfers to a minimum of 16 bytes
> 
> In order to allow Classic MacOS to boot successfully there is a workaround that
> pads all pDMA TI transfers to a minimum of 16 bytes (see commit 7aa6baee7c
> "esp: add support for unaligned accesses"). This feature is not documented and it
> turns out that this is a symptom of incorrect handling of transfer
> overflow/underflow conditions.
> 
> 5) Duplication of some non-DMA logic in esp_reg_read() and esp_reg_write()
> 
> When reading and writing to the FIFO there is some duplication of logic from
> esp_do_nodma() in esp_reg_read() and esp_reg_write(). This should be eliminated
> in favour of a single state machine for handling non-DMA FIFO accesses in a
> single place.
> 
> 
> The series here reworks the ESP emulation to use a SCSI phase-based state machine
> with just two paths: one for DMA/pDMA requests, and another for non-DMA requests.
> The pDMA callbacks are completely removed so that there is now only a single path
> for DMA requests. As part of this work the manual STAT_TC handling is removed, and a
> couple of bugs in the SCSI phase selection are fixed to allow proper transfer
> underflow/overflow detection and recovery.
> 
> I've tested the series with all of my available ESP images and compatibility is
> greatly improved with these changes: I believe that this series should also fix a
> few GitLab issues including https://gitlab.com/qemu-project/qemu/-/issues/1831,
> https://gitlab.com/qemu-project/qemu/-/issues/611 and
> https://gitlab.com/qemu-project/qemu/-/issues/1127. In addition it allows Aurelien's
> really old SPARC Linux images to boot once again, and also the NeXTCube machine can
> now boot, load its kernel from disk and start to execute it.

FWIW, I did some sanity checking by installing an old Fedora 12 onto a SCSI 
disk attached to the am53c974 and dc390 controllers, and everything still 
works fine with your patches. Thus feel free to add:

Tested-by: Thomas Huth <thuth@redhat.com>


