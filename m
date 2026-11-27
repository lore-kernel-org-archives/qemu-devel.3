Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB389606C71C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RbIH3Wj5;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=LTYat7Lt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWwrg-0001Kh-57; Fri, 27 Nov 2026 09:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWwrZ-0001Ia-6E
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:23:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWwrX-0006ct-0T
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795789420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rQQ3pPOeqL+dgSUJ+1xpqPoI8di1kvwf2iUuonGQIuo=;
 b=RbIH3Wj5HGchScydWFfiHFY6EAmemIrIG2y1pQokJlbG0m2TcRue1kagdSwr7T/Mzmqz8S
 gZQJphzV5v6fXi7l8PM6JrTm2smiTkqttBgOVKcCcIZ+UlQFDpqX2MSjgAyIkEtzD0jxZo
 efIxSV7fFe5VeMHdygBMItSShOyZB1A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-UH0KSB3vO_aJeq-DncrwKA-1; Fri, 27 Nov 2026 14:23:38 +0000
X-MC-Unique: UH0KSB3vO_aJeq-DncrwKA-1
X-Mimecast-MFC-AGG-ID: UH0KSB3vO_aJeq-DncrwKA_1795789418
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-948d83322f6so690340585a.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 06:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795789418; x=1796394218; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rQQ3pPOeqL+dgSUJ+1xpqPoI8di1kvwf2iUuonGQIuo=;
 b=LTYat7LtSlUbI01ZHWU3niGetHrBAlfy1WnwhmAtDEDc1SZZ/bdg6/REDsZlDrXqYC
 CjRCOQn1uuydDfen65MwmKPJ7pf1C6yqX/buOO/q+Q36wNBcOe9sXNBgmGk9Mrv118D0
 CW/3cAqHMopIscWNNxbErjEDmzTK9WopknGu4n/A18lUtrYszN2y3HFz+O2OLbYf5v/U
 NJZpvZtU0r6zx8j0VJpr+Mz1+4kLoEBJqL572ePSC9bOXNwh5MwWsQy/CDCh+hCN4qbd
 LkM2P7WLdSa+IEQ53aHQSvXMbvPD/aoB1pwGz1vCvsG8bfIGbXqlu7JhaoN1aN0cBfaP
 /QJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795789418; x=1796394218;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rQQ3pPOeqL+dgSUJ+1xpqPoI8di1kvwf2iUuonGQIuo=;
 b=CTV+B0M/q5IaDshUNLFoquoNipwZvlq2gGxxD8mt1hdbQGIEp5nGXftzmpI13E1LH4
 7gZofd1Yf1sFxoRGXyYNy33zVyqKy1OZChX1EONX1ISubc5obpB2BD6Z9hvuHYJHde9M
 LFmus0bjjvbRq8eZFZ/ZQhOP8zowUXehCgghWzwY7ET6XA+Oc29ptzKpShtQlw2J9MUp
 aFm94tSi1bK783yev8b4mm+ynK7LbBpIGsGv41YzlLouj8JhG4LBxlaKXfjqlY0FE/+Y
 5UdmbGcgR71FvDzjJ1neCy8Zf4Aqqefl64p+xdrjlyVLvXCFjMKXGV/ffJAeW2y2avgP
 CDDQ==
X-Gm-Message-State: APuU4Z+8J6cO0p2iAH9IhqQJ3xydxO4+Gr0JL0AFmMr/he0yN686xc2S
 9OIxOE0/UhP4mNct4Z5uZTbdUqTkq5iKrQIyChIos+3lIRZEDFL/1VpuHP+GHpgA74egVdkqTPU
 AaFq8LYOYHiMGoWISmFjoBc7nFb+NeDovMUsCBYJspp/kUiBQxiAkTjgo
X-Gm-Gg: AZFdTZflW5tFbJo1OwwRGmJzkggvQHAC3zev6ezCbU3jaqxAkCHsHBjVwxbwYqUJ3K1
 zBTlODq2RG14ytBFbaubA5j9+wKu4461xdM9Js61HAyytWs7XbihUOIYonDaB/QwTtfrdGn9UPh
 3Xh/YXHW7CB3RgvRpzIzpq+ftNJddaU64JhtHkNggr6n7GLtA+gocoRwKxPYi+mLzcxYf7cVIRs
 NB/9GEvAxmJP99HUQP//hlNo5DUj2Anc/BxwU6K9l4CQhaCKnxz4lkys6ErhrMe1n2Y2F7q5vMI
 a9Et1CTdp2q+wMUBeSCaIN2iYAgQip0vQWeSMINMeYbO2yad2dbu/Kt99Sn3AWFqJVJqkp1CqxI
 zYLNt1oqUYs9gGdJMjueOi0Ot5368+4GtPW6Gkn2eoUaj/A==
X-Received: by 2002:a05:620a:1d05:b0:949:3066:556a with SMTP id
 af79cd13be357-949bab4d3f5mr4509645785a.69.1795789417813; 
 Fri, 27 Nov 2026 06:23:37 -0800 (PST)
X-Received: by 2002:a05:620a:1d05:b0:949:3066:556a with SMTP id
 af79cd13be357-949bab4d3f5mr4509640985a.69.1795789417265; 
 Fri, 27 Nov 2026 06:23:37 -0800 (PST)
Received: from localhost ([2605:8d80:6cc7:75f8:8c4a:4476:f571:f0d6])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb41a341sm1841957085a.37.2026.11.27.06.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 06:23:36 -0800 (PST)
Date: Fri, 27 Nov 2026 09:23:32 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH for-12.0 v2 7/9] arm/machine: Convert cpu_post_load() to
 take Error**
Message-ID: <awmR_TMQd9c8gxhd@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261126231631.3392756-1-peterx@redhat.com>
 <20261126231631.3392756-8-peterx@redhat.com>
 <87se0mquhh.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87se0mquhh.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 10:22:50AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Convert it to post_load_errp() version, so as to be able to report verbose
> > errors when hit.
> >
> > A few things to mention:
> >
> > - The old "fail" count won't work with Error**, switch to fail and return
> >   immediately, assuming we should stop migration immediately hitting the
> >   1st error.
> >
> 
> You could keep the handle_cpreg* untouched and just create a new generic
> Error when fail > 0 like you did for !kvm_arm_cpu_post_load() and
> !write_list_to_cpustate(), no? That way we don't lose the reporting of
> the other bugged registers.

I can, but I thought it was good cleaning up those error_report()s.  I'll
see if PeterM has any preference on that.

-- 
Peter Xu

