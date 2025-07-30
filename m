Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC11C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 09:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh2tm-0007XZ-GW; Wed, 30 Jul 2025 05:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uh2dd-0007Lc-Hh
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 04:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uh2da-0007c6-Gb
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 04:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753865891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y6B7r/L+AgEdRwJmEfe8LfiGeIspLhpnXLX0QLwDVHo=;
 b=RiTQt6BIZgg4OmjBiZXCpHXk0mo6n+P0vIvhDLUn9avh67H7mMsUC1NxpJ7PO3liLSBmvn
 z1LCOhwtkmLOKl/CHiqylaolLPZVHlUF+uPxk4Q5slM+CQ/jVJgwIfP0zCDOjMN52GhfDd
 TYjF/1o8ZaLNfP4jBLWJTnlpkCNwgOU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-2SSn5OY5NdGwaIPjxovHgA-1; Wed, 30 Jul 2025 04:58:09 -0400
X-MC-Unique: 2SSn5OY5NdGwaIPjxovHgA-1
X-Mimecast-MFC-AGG-ID: 2SSn5OY5NdGwaIPjxovHgA_1753865889
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45600d19a2aso50290425e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 01:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753865888; x=1754470688;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y6B7r/L+AgEdRwJmEfe8LfiGeIspLhpnXLX0QLwDVHo=;
 b=eXF58014eNlL8wMrBwE+elPxeyz/xInd78+f8Kopa7YDL87/7Y1aAbT0MtcTOFFtWT
 834roe4lrz2bsEm/QUhsPC4a274x+W+LCNFWGFKf0FX+2ohNjhqriw0TLJ4P1Bl1hwZf
 jX7/r8lSx6IRokWu7eWSSVtb8dVL87ymbtM8inS296mPTA7UQA7BKswCO9Z5UH4NkESG
 8j8Vj0czX+8D87t+AMFqGhon//Yxc6jfJGU/Dvkr38tE+LFRGuBe9CBEC2sotSUJYaYR
 mlVBVhfPzjrsovUoRMtHhuTd9Sbx6rQYDFfvNdLbT2VJi3ui/ZeansJlm9wKRBkABI1d
 GKbw==
X-Gm-Message-State: AOJu0YyfCk3fQMqG5HA1uEswq0OEFwYkeSD7oIaWvhiWuRz0wTo13iUq
 WqWfUDZbK1PEjf1Tu5X/r0a6V45Z/grZ6LcxmJRkdL/5LIFncz0BHYwzOCkkT/FbI7cBRQu6DHO
 ppIZyZ0w21ZtdLzofoU2ObZVKXDYAKGM//AmyaEgmPYG/iNQEeaiTKYew
X-Gm-Gg: ASbGncvcLFnnloTS4IqSCgRhr2fGvRAY8UG6k5NvN+yBticrCmtJrIS9jd4KdqieRQ+
 w0Q4EH6VpMxeL7YIlQe+wlk3hpuHNL8gBnRGaGIlgGyDaN3JSJGuf+8fgrr4Xxd+BkIUg61QFAa
 /kfs65fjPa6vFPaODstlyYrVz3fFqYHl7GkWSwDJZ4WTVwRjm2dqK9H8FIAMOZje4R9+oAs++s7
 YJahLaU2wbb0fbOCAFGmwBupsOG6bCl250bgjBpCvCu7VTpD8HQaCJ6kZi/o96Nb7WynBiKDFwN
 HLgDiAaebYqgU0VnoHcsfzBgs9iNV6NASHhStX/2hBrWIm61FamDrkw/5HGll/h0pJzUFSIAs8r
 w76A=
X-Received: by 2002:a05:600c:8b2a:b0:456:f1e:205c with SMTP id
 5b1f17b1804b1-45892b947e6mr23724835e9.4.1753865888441; 
 Wed, 30 Jul 2025 01:58:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAOuM1PkgsFCskTPBdPFJ5pJh+Xe7lBFBZA/QZYKw8vB6LL3+K0Bycg+K0A+WBA4uIUiwtmw==
X-Received: by 2002:a05:600c:8b2a:b0:456:f1e:205c with SMTP id
 5b1f17b1804b1-45892b947e6mr23724585e9.4.1753865888022; 
 Wed, 30 Jul 2025 01:58:08 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-093.pools.arcor-ip.net.
 [47.64.115.93]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589539de63sm18271415e9.23.2025.07.30.01.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 01:58:07 -0700 (PDT)
Message-ID: <8f0c1352-6dba-4b44-bbb2-f2ab83458058@redhat.com>
Date: Wed, 30 Jul 2025 10:58:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qga: Fix ubsan warning
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 qemu-trivial@nongnu.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250730072709.27077-1-thuth@redhat.com>
 <CAPMcbCp6cDWnV4PLnyYO5+rGoSeFEPSvGAOyJjK4N8r5Zkdv_w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAPMcbCp6cDWnV4PLnyYO5+rGoSeFEPSvGAOyJjK4N8r5Zkdv_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 30/07/2025 10.28, Kostiantyn Kostiuk wrote:
> Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com 
> <mailto:kkostiuk@redhat.com>>
> 
> @Thomas Huth Is this fix critical to merge during 
> code freeze?

I don't think so, the problem only occurs when compiling with 
--enable-ubsan, so normal users should not be affected by this.

  Thomas


> On Wed, Jul 30, 2025 at 10:27 AM Thomas Huth <thuth@redhat.com 
> <mailto:thuth@redhat.com>> wrote:
> 
>     From: Thomas Huth <thuth@redhat.com <mailto:thuth@redhat.com>>
> 
>     When compiling QEMU with --enable-ubsan there is a undefined behavior
>     warning when running "make check":
> 
>       .../qga/commands-linux.c:452:15: runtime error: applying non-zero
>     offset 5 to null pointer
>       #0 0x55ea7b89450c in build_guest_fsinfo_for_pci_dev ..../qga/commands-
>     linux.c:452:15
> 
>     Fix it by avoiding the additional pointer variable here and use an
>     "offset" integer variable instead.
> 
>     Signed-off-by: Thomas Huth <thuth@redhat.com <mailto:thuth@redhat.com>>
>     ---
>       v2: Use an integer offset variable instead for checking for a NULL pointer
> 
>       qga/commands-linux.c | 10 +++++-----
>       1 file changed, 5 insertions(+), 5 deletions(-)
> 
>     diff --git a/qga/commands-linux.c b/qga/commands-linux.c
>     index 9e8a934b9a6..0c41eb97190 100644
>     --- a/qga/commands-linux.c
>     +++ b/qga/commands-linux.c
>     @@ -400,10 +400,10 @@ static bool build_guest_fsinfo_for_pci_dev(char
>     const *syspath,
>                                                  Error **errp)
>       {
>           unsigned int pci[4], host, hosts[8], tgt[3];
>     -    int i, nhosts = 0, pcilen;
>     +    int i, offset, nhosts = 0, pcilen;
>           GuestPCIAddress *pciaddr = disk->pci_controller;
>           bool has_ata = false, has_host = false, has_tgt = false;
>     -    char *p, *q, *driver = NULL;
>     +    char *p, *driver = NULL;
>           bool ret = false;
> 
>           p = strstr(syspath, "/devices/pci");
>     @@ -445,13 +445,13 @@ static bool build_guest_fsinfo_for_pci_dev(char
>     const *syspath,
> 
>           p = strstr(syspath, "/ata");
>           if (p) {
>     -        q = p + 4;
>     +        offset = 4;
>               has_ata = true;
>           } else {
>               p = strstr(syspath, "/host");
>     -        q = p + 5;
>     +        offset = 5;
>           }
>     -    if (p && sscanf(q, "%u", &host) == 1) {
>     +    if (p && sscanf(p + offset, "%u", &host) == 1) {
>               has_host = true;
>               nhosts = build_hosts(syspath, p, has_ata, hosts,
>                                    ARRAY_SIZE(hosts), errp);
>     -- 
>     2.50.1
> 


