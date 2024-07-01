Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B913C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 21:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOOUO-0001rL-5V; Mon, 01 Jul 2024 17:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osandov@osandov.com>)
 id 1sOOUN-0001r2-8F
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 17:23:07 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osandov@osandov.com>)
 id 1sOOUL-0000s3-38
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 17:23:07 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2c7c61f7ee3so2109935a91.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1719868983; x=1720473783;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nPKbPueoYk62vc4MpTTFzo3VrSpoT49HVPv50uqcuOY=;
 b=rRwvNoHN3IezxN8JxqQxy1pd5P20h9BHaWzYiObqk43YetYhH5rCU9GWWSweeiYxUl
 YmwRtGuAckN6AKaO4B/2yfv+SLJ++4yYeeyOC/t6ucUBLOlEP8ErK/CuMBSeqm2WcjZw
 PmpNoENBVZpFgtgvre7A7YdPfcqKGGrSUx48uB4/0hT1u4nEZGAkAv9ZviNnwQA7cPuf
 CbhhBWV6sWWIhooEBnkt9jBduvhFYsQisR9qe9l7fbwiHsrRSxUluWFsBE6/xiinmxrG
 yd/D2GHEk7KaHdZTurfFJkPd+J6PNkp3uqGa6T0lloa8HXwODLFgJ8rNlIGkhXrlB16u
 oIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719868983; x=1720473783;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPKbPueoYk62vc4MpTTFzo3VrSpoT49HVPv50uqcuOY=;
 b=U4vHSIfjxMsJ/NI7REoBFuPz78cp0EjOZchk81eFFCsDJjAcGV4bHwtqEsivejFSrB
 fE4OzuKDZdJBN194oGD5u79Nrllu1ZGPeDEM6NFC/ecXnfxLXPUuDEe3tAe7pee32HrQ
 0PvAfy0moEouISKU54Ay37rEYHsceZichbqApMFUnrQnZAJj1Whv2R+wL4SOWB8ZSmL2
 q9reoCALtdNp2rKU2R8Dp62hF1qPiLlhmL2IZ63B3zN5JmKLkbbMT5uSxfQIhAlSsSlt
 IF+g0Tk4ZfMI4I0oh4CFZ8MZwIa4Nt8QubLWK6q1+1ksfm40n7ZCsUJkFDKYbcy2RlPT
 hwfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU56NhEt67a+EagefcsnlVDRv6tC+LdCns5Ovt8aBcVKBrV9bzAZMN8B2+bKN/MN4YgI9DvrIWhyC4RHqy+PhDVmQKxCGc=
X-Gm-Message-State: AOJu0YzA4vygH3g03ycR7foTnlTQePzUXBvsjfe5DRJAdHQ6OIQH2jav
 2jIuBr4RRgSdDn43mCe0QIyQqWlpnSLvNixyufsrADK7lLbCND4JRKu/+7Ggs5V3vhdlGmwIjHo
 0
X-Google-Smtp-Source: AGHT+IFi10TcWB9AJHIA7MCZWopRH2eTvDjB0HyQTRnGmPTODGKHG4fLrZYxYYzxBWCDQQ3qb7CsrA==
X-Received: by 2002:a17:90a:d716:b0:2c2:f704:5278 with SMTP id
 98e67ed59e1d1-2c93d771fb3mr4078211a91.42.1719868983538; 
 Mon, 01 Jul 2024 14:23:03 -0700 (PDT)
Received: from telecaster.dhcp.thefacebook.com ([2620:10d:c090:500::7:a5d])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91ce1f198sm7295202a91.2.2024.07.01.14.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 14:23:03 -0700 (PDT)
Date: Mon, 1 Jul 2024 14:23:01 -0700
From: Omar Sandoval <osandov@osandov.com>
To: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] target/ppc/arch_dump: set prstatus pid to cpuid
Message-ID: <ZoMeNacKzEu1PzuW@telecaster.dhcp.thefacebook.com>
References: <3c3dd56b4e88b6863e971d72daae7c0324499712.1719852483.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c3dd56b4e88b6863e971d72daae7c0324499712.1719852483.git.osandov@osandov.com>
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=osandov@osandov.com; helo=mail-pj1-x102c.google.com
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

On Mon, Jul 01, 2024 at 09:51:35AM -0700, Omar Sandoval wrote:
> Every other architecture does this, and debuggers need it to be able to
> identify which prstatus note corresponds to which CPU.
> 
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Oops, I forgot to copy Thomas's reviewed-by from v1:

Reviewed-by: Thomas Huth <thuth@redhat.com>

> Signed-off-by: Omar Sandoval <osandov@osandov.com>

