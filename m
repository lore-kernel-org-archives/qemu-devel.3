Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9F2C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPfs-00083E-Rb; Tue, 03 Jun 2025 07:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uMPfe-00082N-0J
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uMPfa-0004fC-JO
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748949540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NJYa/cPq1H7ske+bt18ukP+85xo8uTfK89lql1FNx8Q=;
 b=asgkVgg/3bk6PptvDRuennbWNDsrCfyz0lSKcJTC6RDlZmsp+jDzbRV9tMmSWROCOdhJqQ
 Wd5zz/vVgptUWMPi2ckMVgPmDuf0ALNuQTmpm4rvzAn7/LhT/NAKPn45L4RO9rHn/ETFeU
 vi7KCMjzg4b7WtveWq0n35n2n7Tsg+Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-cemPKKkbM6yf-sRmWdXooA-1; Tue, 03 Jun 2025 07:18:59 -0400
X-MC-Unique: cemPKKkbM6yf-sRmWdXooA-1
X-Mimecast-MFC-AGG-ID: cemPKKkbM6yf-sRmWdXooA_1748949538
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4fabcafecso1664783f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748949538; x=1749554338;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NJYa/cPq1H7ske+bt18ukP+85xo8uTfK89lql1FNx8Q=;
 b=TGZyD5ugFMUAKs54qokbpsebCRLimn4+TqAoDyt2RizT0oNu5Vm6iJYJ6G4rQEuhAG
 5+4Tpcxr4q2fNoxrFDwB0dQuG8mrvmQLtEXTh3Gfl7CEwuKa1EfAgVfeWW1Q/d2DPsck
 8GUggPxpRYg45czaV69EL9d9Ab3MX+rv0T84O5gZ3pkfBKwos9+ElpwKL0clChnYaffe
 AGhnXFDhbvbFyKUBA0uuaZOlrhLu3VNU5YUbdCgOKZPLBjyBgC8NIDJ47go4z/TcqXS7
 jWisXzs8JYj9SGF4f9HnVhPC9X/cpB5oApc9BXIjm+DjkXatAP7BTRQbrOjrg4zVIJu8
 2nQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKxL8FdbYpOuWXqE/WR+nIkeaucMftehbqZZY+tbV+E56lEUFhu5+S6wUa5/N9Riq6K9sgPuFbg2HP@nongnu.org
X-Gm-Message-State: AOJu0YyRYzuV6wmzoha2gDygYFIWD87VrPvmOfsLVByhAZIQOUkRhcAV
 JyEEOxcEmzU5pwVx68HqLqQ8wjrQ93Zdvi4jbFCsjN0fl/RSx8/MFlU6Zk0G4yBu2lnIFIeFfnm
 7XWWVpquqVSgWIl6bjNclxtd4M4cMsRvCIxpl3XfUcIX65pK83rXFOluN
X-Gm-Gg: ASbGnctVSer21pnAgy33TO0xFbehswXOdq3V4E/cap0K1cIUJ/Jar5Y8iN8EPBazKRe
 ucjCvzFKq0B9nDoib6UtYfZmyueRH/zxxHtB+SsiVuaH510cbgo4NIyt7UJGk/fyrQZpcgci5LV
 wEpO+ZRzc7+r0Qwo7Ckg/MZgzsnNkPReJ0fFFByXLNaTCgEOSS76vKxCT1O1A07TJbl0WgPFjX4
 pIQ0oeYY01HeQ6yf/TiuChADSs849+HK0+Czlh+kR8hR/UE16NncsHyARgHZmOCuceJpJ2NE29I
 ZDDFC6OacqAyEFafphfLesykWNeDFTvhpEoHFsNObWU=
X-Received: by 2002:a05:6000:1889:b0:3a4:cbc6:9db0 with SMTP id
 ffacd0b85a97d-3a4f7a7ca88mr13671159f8f.51.1748949537816; 
 Tue, 03 Jun 2025 04:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC8b40xLi63xJ4WZrUPpc3naNCGjjBkXHhaMXtCl+QcYYCM9rtEQHVFNo6QBlCpvxbAObjWw==
X-Received: by 2002:a05:6000:1889:b0:3a4:cbc6:9db0 with SMTP id
 ffacd0b85a97d-3a4f7a7ca88mr13671138f8f.51.1748949537400; 
 Tue, 03 Jun 2025 04:18:57 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-214.web.vodafone.de.
 [109.42.50.214]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b79asm17600366f8f.2.2025.06.03.04.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:18:57 -0700 (PDT)
Message-ID: <e6c7920b-8078-4d97-92ce-2efafb645953@redhat.com>
Date: Tue, 3 Jun 2025 13:18:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/23] ui/vnc: take account of client byte order in pixman
 format
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250522102923.309452-1-berrange@redhat.com>
 <20250522102923.309452-3-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250522102923.309452-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 22/05/2025 12.29, Daniel P. Berrangé wrote:
> The set_pixel_conversion() method is responsible for determining whether
> the VNC client pixel format matches the server format, and thus whether
> we can use the fast path "copy" impl for sending pixels, or must use
> the generic impl with bit swizzling.
> 
> The VNC server format is set at build time to VNC_SERVER_FB_FORMAT,
> which corresponds to PIXMAN_x8r8g8b8.
> 
> The qemu_pixman_get_format() method is then responsible for converting
> the VNC pixel format into a pixman format.
> 
> The VNC client pixel shifts are relative to the associated endianness.
> 
> The pixman formats are always relative to the host native endianness.
> 
> The qemu_pixman_get_format() method does not take into account the
> VNC client endianness, and is thus returning a pixman format that is
> only valid with the host endianness matches that of the VNC client.
...

  Hi Daniel,

this patch breaks the output in the TigerVNC viewer for me.
If I run "./qemu-system-x86_64 -vnc :1" on my laptop, and then connect to it 
via "vncviewer :1", the output of the BIOS now appears in yellow letters 
(instead of grey ones).

FWIW, the output of TigerVNC viewer is:

  TigerVNC viewer v1.15.0
  Built on: 2025-04-08 00:00
  Copyright (C) 1999-2025 TigerVNC team and many others (see README.rst)
  See https://www.tigervnc.org for information on TigerVNC.

  Tue Jun  3 13:17:50 2025
   DecodeManager: Detected 16 CPU core(s)
   DecodeManager: Creating 4 decoder thread(s)
   CConn:       Connected to host localhost port 5901
   CConnection: Server supports RFB protocol version 3.8
   CConnection: Using RFB protocol version 3.8
   CConnection: Choosing security type None(1)
   CConn:       Using pixel format depth 24 (32bpp) little-endian rgb888

Could you please have a look what's going wrong here?

  Thanks,
   Thomas


