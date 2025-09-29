Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00BDCAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Fpk-0003yb-I8; Mon, 29 Sep 2025 11:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3FpJ-0003tq-1w
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:30:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3FpB-0001h4-4V
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759159797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VNiv9ZgbthKEdix6/c00x5jnVy/OuDbqGH2b6KKB+Nw=;
 b=JQyqfhF7G6akx7Mw19P1hTrjR2gWdZY+aon3oYHKRZp0dp/49zsL7u+5MCWELvHhiANky0
 lxEFsO2GsLuoRu3UsVeQDrhQsxilkWDqYRDElefGZlrPFR30Ad5jcJKD3u2TxOqsNZX3H8
 tiSZjX19y6l9MYn3AuPneW1ltUlsxnU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-l38J-PJ2PHGbtDic-XwJlg-1; Mon, 29 Sep 2025 11:29:56 -0400
X-MC-Unique: l38J-PJ2PHGbtDic-XwJlg-1
X-Mimecast-MFC-AGG-ID: l38J-PJ2PHGbtDic-XwJlg_1759159795
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8635d475527so787447285a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759159795; x=1759764595;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNiv9ZgbthKEdix6/c00x5jnVy/OuDbqGH2b6KKB+Nw=;
 b=DbvcZcQ3BjOBvN/gaiNrYpRMCU4RgbfWiG5dH6dMITizjAHsklHe8/Yzh9MpewMjdI
 iP9lRprOtMCt4hTv+wkiNkMi77ToJyCirYsJnNWpsly9/ONeDI1pK1+keKweZ55N//KW
 JteQTJ8D2/50/LPv3w9jJ4WTYwQEgzUTMl+AIYthiUHmfsXTDGG+ZFaAGdoDU+mPYuyV
 in7U2jOgAClQR/4dBl6AqPuMb8u4SmnkJytlMkzZvgZmF+rBBGU/bsTk56EyQHnKFkAA
 JYJyiNqUTycEOO3tuzv8ATY3DY1rQU45hPDZzwNL7HA91acl847b0LeU4Dnfvo+IY894
 4mHA==
X-Gm-Message-State: AOJu0YxdsbrDujbmBb8PhM8m4N41dWsfNr/aJhiTeJceP80R+aBkaCK2
 cmVSZC+0vy4VckU0fFWEgZPyzTn2XT4IP4t2UsbPffmSj7H2pdOsU1wb3P+C5iD/oWXEUp254BN
 a3M1kjuaYQjXS4P/H4pK7VUWQ3v5QQ+Xp6G627yVAxuVqfRcfNevPn3dW
X-Gm-Gg: ASbGncv6JTSCUH9OcgsEGKnTLHEbnPCrMnAEKmZpYxHoIpqXG8sE8UMvKWuaTTH77Ls
 OFqlav0MhlnXG2plcLbsDqvgiQvFXIlFBrRilm6GebrRmB7rPDnrb1jEgPNYUcxlEWsApKw21ot
 RdN0lptGZWj9hziJsJ6q0B+zv9d/we0CeoS+TL2O08O3F/p5K5PULnyMtiPD02hvTXlzAqxqXwz
 wPLFuZSUJhoA1W4hi4+ZHp6cGHoMPoRIyUAvKA0zgjMCtd17njbmlMYYjESce3+noTpuwttlMJt
 pIWWGXjaVwo45q4HnS1pduN4ARPfafPz
X-Received: by 2002:a05:620a:29d2:b0:813:41c3:e888 with SMTP id
 af79cd13be357-85ae061bc62mr2360267485a.32.1759159795388; 
 Mon, 29 Sep 2025 08:29:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbAe4zWRo71M9xTdPvmZjG9Q5tYTwjlZwIBBPgQaz5N/WHJeAUDR09HMlv72vnecVUd60QjA==
X-Received: by 2002:a05:620a:29d2:b0:813:41c3:e888 with SMTP id
 af79cd13be357-85ae061bc62mr2360261785a.32.1759159794738; 
 Mon, 29 Sep 2025 08:29:54 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-862e20312f8sm612232485a.42.2025.09.29.08.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:29:54 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:29:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH] migration: HMP: Adjust the order of output fields
Message-ID: <aNql8ZfkTAg5gJde@x1.local>
References: <20250929021213.28369-1-guobin@linux.alibaba.com>
 <aNqT4mJWxdYJt4Wc@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNqT4mJWxdYJt4Wc@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 29, 2025 at 10:12:50AM -0400, Peter Xu wrote:
> On Mon, Sep 29, 2025 at 10:12:13AM +0800, Bin Guo wrote:
> > Adjust the positions of 'tls-authz' and 'max-postcopy-bandwidth' in
> > the fields output by the 'info migrate_parameters' command so that
> > related fields are next to each other.
> > 
> > For clarity only, no functional changes.
> > 
> > Sample output after this commit:
> > (qemu) info migrate_parameters
> > ...
> > max-cpu-throttle: 99
> > tls-creds: ''
> > tls-hostname: ''
> > tls-authz: ''
> > max-bandwidth: 134217728 bytes/second
> > avail-switchover-bandwidth: 0 bytes/second
> > max-postcopy-bandwidth: 0 bytes/second
> 
> This can be moved even above "avail-switchover-bandwidth", IMHO.

I queued it with this change, please shoot if there's objections.

Thanks,

-- 
Peter Xu


