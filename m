Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790E1CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 23:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPq7s-0006fl-LE; Wed, 20 May 2026 19:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wPq7q-0006fX-Q7
 for qemu-devel@nongnu.org; Wed, 20 May 2026 19:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wPq7o-0003DZ-W2
 for qemu-devel@nongnu.org; Wed, 20 May 2026 19:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779318888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jaSaXT/+vMeI4gtAtJWLUOaFdJzAvLRpxCa59sFmbr4=;
 b=dx4mtUK+tjiflV/eGwO2UFe031WcA/2veeiSkKOCG+Y+1NLYQSNKx3BFqBjShGEz3gwFV3
 u/r+acYzmMUKi4Rpkdlli6MaBZkL4s9Fu4YGWwyDOTmXU/6qW5EZwrxVYP8tZdCKjCLEHo
 sZU5G049L6hJ4iUrqugeBNLV6uNnN80=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-Nzaret5aMF6gtBUekqXWRw-1; Wed, 20 May 2026 19:14:46 -0400
X-MC-Unique: Nzaret5aMF6gtBUekqXWRw-1
X-Mimecast-MFC-AGG-ID: Nzaret5aMF6gtBUekqXWRw_1779318885
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48fea6292a5so25209655e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 16:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779318885; x=1779923685; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jaSaXT/+vMeI4gtAtJWLUOaFdJzAvLRpxCa59sFmbr4=;
 b=Ki4fBI1cqaED08v6r5I4v7140eyzuPdN+44B7SdfTpQnOingmC1caiV8T10Dt3Bzt6
 xAE8bDjt8rrfHn/Y/Ww1PPJUfpQKyo178HXloZ4XarCvBtS32vSXO44PvGNqGoyPkjkx
 +gIYTJCkc4QVzhZja02QgMcoCpD2yKF/7YLgl+8khmNZOw+C+KevYeWouJ73MZN5mwm2
 A+OnIXj0HRY1s5iTDKE69/qzDY4Uc5ipYr9BGJaprAXYvD3RxnzKni8a1TVC1K611wOb
 menDXSNsCOkLWGSI7G6cDH5PJjW2PW8vs/D8CCQfwcST9HiH/rXEWwaTLbe3twYODi6H
 DYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779318885; x=1779923685;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jaSaXT/+vMeI4gtAtJWLUOaFdJzAvLRpxCa59sFmbr4=;
 b=pN/cVVmAtEUpCvGQWSc3SdKnQYQixGvH6VP2ypmMSVShrVy2xp0HDxS0Z81gLlt55h
 eGyV0rFuA9V5AHpHCckAC4rEoVQ4GFHsd/JoW9y7aP57vn3ptXYbXzhK6FzWbrSB06Kk
 RQDcwkN9pJeyx8nritAAQcmrHvDXekAwBEDbPHGpdMu+kvLKlOU+AouDHdLoM1RqHJKH
 C51939VM2V9BMPpVpEH39SKWev+MATlyPwXFXj1FNwjjdxGCU9ylTzF0GAwL/YPgteNN
 0w/Za33PMggzHANBotB8VS+uClbEjseKjh82+NgyXRmhSRT9UwP4nSZgSjMp8yOG5nMT
 B/4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IX4doEw1fhG0WO/Z+ndIdUZaJRnW+IZtbFRs7Ypzo2W+DipouLOzeV+BLWVLmXD1DPeKSS40kgV5K@nongnu.org
X-Gm-Message-State: AOJu0YxNimbaUGNFQTp3xgVcP8Sh2y2uVS+Cvul4Bj0d5q0i5s1hryGz
 BqPa3n0cUFv29jqGZ+nbGPnepeDqPBI74WBkWhpmhbNmDwwpGRV5Wb7+RzKWzJadaWOyt904KhD
 c67ML9wM4/KIPbWJsDV631rUjALOThzLWvGW6vPPiUzCPt0eObcXF0/jD
X-Gm-Gg: Acq92OERE/dp+y0gYrZCjRtvxFzFB/OwGYdBE5MAHvww70ck9yb8nbh+BskaZg1WXlp
 XUx4K7tcWq9xZ+hGg4hCnVX5E2EngoEZzGGWr0JMWD4KMC9zlPI0J/Ivavd1XmmOyw4o6Lluzbz
 cb3BNjpZHAinZtYAg9CG+AgikTS5WMAA9CHD2EEny5zaZr343GOUPHlfov+8RdYPP39SkYxgHxq
 SXe9uze8dtNI/w6A+uGa+EQ7CPpnyRdXC8RsK+7uXh0/XQKcJnY6G0vvYiNGUtKiYMoZrIbUd7x
 g7MOujTkfobxbRRlySzH7c1yMdTwG/KGBz5YnBGv78/z6NWRyhsnAvhim18TIJ9B6fcdRd10pDE
 WgcsW4rWVgn4OG3HUrrVBwFYXL371WcqunbiiwsR8lZ8=
X-Received: by 2002:a05:600c:4a1a:b0:48e:7854:1608 with SMTP id
 5b1f17b1804b1-490360a6e70mr2593585e9.25.1779318885172; 
 Wed, 20 May 2026 16:14:45 -0700 (PDT)
X-Received: by 2002:a05:600c:4a1a:b0:48e:7854:1608 with SMTP id
 5b1f17b1804b1-490360a6e70mr2593475e9.25.1779318884639; 
 Wed, 20 May 2026 16:14:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033dab0besm21074075e9.15.2026.05.20.16.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 16:14:44 -0700 (PDT)
Date: Wed, 20 May 2026 19:14:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Mauro Matteo Cascella <mcascell@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: RFC: GitLab issues for security disclosures
Message-ID: <20260520191235-mutt-send-email-mst@kernel.org>
References: <agxzKzzDOJm1EU_v@redhat.com>
 <c9cd8228-0a18-49f7-b403-445affeaf972@oss.qualcomm.com>
 <ag3OopKwGVUjSrrV@redhat.com>
 <e7f1fd11-774d-4610-8cca-a434f508e472@oss.qualcomm.com>
 <ag3xwssG6KZecv0o@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ag3xwssG6KZecv0o@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, May 20, 2026 at 06:39:14PM +0100, Daniel P. Berrangé wrote:
> On Wed, May 20, 2026 at 12:33:16PM -0500, Pierrick Bouvier wrote:
> > On 5/20/2026 10:09 AM, Daniel P. Berrangé wrote:
> > > On Wed, May 20, 2026 at 10:01:14AM -0500, Pierrick Bouvier wrote:
> > >> Hi Daniel,
> > >>
> > >> On 5/19/2026 9:26 AM, Daniel P. Berrangé wrote:
> > >>> The qemu-security mailing list was created several years back now and
> > >>> traditionally saw 1-2 disclosures a month at worst. This was manageable.
> > >>>
> > >>> Since approx March 1st, the new normal is to see as many as 20 disclosures
> > >>> in one single day, more than 200 in total now. This is unsustainable.
> > >>> I was thinking we needed more people on qemu-security to triage, but IMHO
> > >>> this won't really fix the problem.
> > >>>
> > >>
> > >> Considering the increase in number of issues, would that be possible to
> > >> make stricter rules about what is expected?
> > >>
> > >> For instance, asking for a working exploit and optionally a VM image +
> > >> instructions to reproduce it. I am not expert on the topic, but what I
> > >> see is that if we have this, all duplicates would be eliminated at once.
> > > 
> > > With the new crop of AI assisted disclosures there is absolutely no
> > > lack of data provided.
> > > 
> > > Most come with reproducible exploits, detailed descriptions and analysis,
> > > and more - everything you could conceivably need to triage the disclosure.
> > > Reading and interpreting this takes significant mental effort and there's
> > > too much data to quickly/easily eliminate dupes.
> > >
> > 
> > Maybe we need to "standardize" this part then.
> > Or do something like asking a (GitLab) CI pipeline to be written to
> > expose the issue. If we can just run this with a specific qemu
> > remote/branch, it becomes trivial to rerun it when fixes are pushed.
> > 
> > It definitely does not solve the original scaling issue, but maybe can
> > help to absorb it, and spend time where it's useful: writing and
> > upstreaming a fix, and check it "broke" the exploit.
> > 
> > >>> This needs an issue tracker to cope with & email is not an issue tracker.
> > >>> We faked an issue tracker with a shared spreadsheet to prevent us drowning
> > >>> these past few months, but this is still not sustainable & probably won't
> > >>> ever be.
> > >>>
> > >>
> > >> Overall, you're right.
> > >> However, changing the tool won't solve the number of issues sent, and
> > >> for that, something additional is needed.
> > > 
> > > I don't expect there to be any change in submission rate. The proposal
> > > is based on the expectation that the submission rate will continue at
> > > a high level for a long time. Primarily the goal is to reduce the
> > > tracking and triage work overhead and to eliminate/reduce single person
> > > bottlenecks in the process
> > > 
> > >> I wonder also what is the percentage of duplicates there is from what
> > >> you observed in the last 2 months. Any rough idea of the number?
> > > 
> > > Definitely at least 10%, probably closer to 15%.
> > >
> > 
> > Ok, interesting number, thanks. I was expecting much more, but I'm
> > biased having heard Linus this morning talk about this for Linux kernel.
> 
> I expect the dupes to increase over time as more people run the
> same analysis across QEMU, especially given that most of the bugs
> are not yet fixed. 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


something I was unaware of previously, is that gitlab is a CNA:
https://about.gitlab.com/security/cve/

so using gitlab issues means assigning CVE #s should be super easy.


-- 
MST


