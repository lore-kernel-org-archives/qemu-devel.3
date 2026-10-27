Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE0606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NHLGgyRu;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KYvzpCLH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLejQ-0002cc-7C; Tue, 27 Oct 2026 06:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xLei0-000756-9q
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xLehw-0008Oc-Ng
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793098017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mKLxufQdxx6mW5ZQDfnqG9uoMRqbmtQ2JPw6QBj3EM0=;
 b=NHLGgyRus4CXvAJx6jZQu4YosjWm7vzpjVl3X23WMUWmpmO6hrkPnrms5TRQ7s3JyFq0oG
 z1eX/NfnNZcyc8aYcxC4hb87b673jgteuFRPZ55sDVeD0lIw4+AiwFJd0qfybVCswgc3GC
 zfzQg3A+Am/TlqaPRCBQDVAPy7tDzF4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-I0zqAG-0NO-cN6ij0lU1eQ-1; Tue, 27 Oct 2026 06:46:55 -0400
X-MC-Unique: I0zqAG-0NO-cN6ij0lU1eQ-1
X-Mimecast-MFC-AGG-ID: I0zqAG-0NO-cN6ij0lU1eQ_1793098014
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48e1ad3cb66so2325519f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793098014; x=1793702814; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mKLxufQdxx6mW5ZQDfnqG9uoMRqbmtQ2JPw6QBj3EM0=;
 b=KYvzpCLHjwG8nu7eJwnMp4o65RJ29cwHvGbA5i8O27L5RQaFfOACbnP4NwljkXOg0R
 PbFhG8OMbU94rPqFbLj3uSCQxjRydl9GTiXYikZGxB88llkSw4rjmUlpHyA613atmDFW
 UyLkd6lm+c0NGqFRxgxA6JA/0GPFVuiWLwpfLS67ZEfAkIO152oDdCFcVNmLyfkgYVQq
 GLcJpRaDs6nHw2/JiMPR5PxqR3xnuV/c34WoY3m6BaQH+Ebi8cOGeHaJNljwUcaEcxrZ
 A0iLYXSBwcQeWqdfr05J+RiO9AaPA08prweg7GB5k1wRfHvtb+dzKXUYWsiECVv4DOaN
 pbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793098014; x=1793702814;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mKLxufQdxx6mW5ZQDfnqG9uoMRqbmtQ2JPw6QBj3EM0=;
 b=LU89IA0V1q7EwzbY5AInPBjOgHMLYui1wO6tmJgpNpBFcK3DW3KIBOxjH8DHuG6rnC
 XInRkqdIMewyjRgbKcgkYG5L47XtWNT+66fim8s1IRwvx/FKohx68Qnhh2NpNku9dXqS
 tJmATVzktAqcenOusAtUw1Y4eN3hBJudprhLBbyPmyyeawkfc81Mqj2bi5NmhZhFrnbe
 yfaD96ET7w3bRxLtWnYBXR/B6kK2/TerZx06IHi2OaUJ3Sd4g+tpgwgCenpHkfrejTzi
 7peaejO3+pM6o9BihYHrw0zUZaQakzHEj/Y/Z7A/tG/yYtQmJNqq4JnoH7PjoQMaUvsU
 C3mg==
X-Gm-Message-State: AFq9FYIKeUjpzO9s9gCQ/h28ebtypL2aLS78xC1e+QY1Wf32V5JLgHeB
 BKNqywx5ox7vVjWDmIhvXrn4DaEOVhHSMrn7jJM8vwfWkoTJY9wbZrjDOEV4tWaEEDjopM6UULA
 zb7Q+yg6HOcH//Xo/RJDe3nHeF9BoTifrH7hfOJ/xLQB5AMmh1tHyTjwX
X-Gm-Gg: AYBFou1eyIUXPnEEe8It3Q6ZwSSBHBf/dG0FYZuGQ7MsIvdraCcAr6CauHyYzwmC/35
 webVcJOvlLrxa5Qb8vLAUu/POhK/AuNJV2gcoi2h7RywaXqd3zJkz3CZXeQNKNZcR0y8vagTACV
 5oYIRvJ+1Cu6bqFwhwe7tzUbIMYJatyKS1XY94nyPNuQngxbLTdp3Q2nc66StFHefEj05hjfNTH
 FsKE/M2/xntIor4aJCpLiPuEASRAer4JQdEHNGkz0ZiN3gFoxqaBIg2bDBLqXC1etn5k8g5Yfjr
 6iwvSctAc7YS8yoOiQD/RhDwm/n7exgK4jbY8RRwlCpUobDAx0+M0QTlzVpNACn6Mhk=
X-Received: by 2002:a05:6000:2999:10b0:488:654b:ccd8 with SMTP id
 ffacd0b85a97d-48e3eb4685cmr12314817f8f.6.1793098014131; 
 Tue, 27 Oct 2026 03:46:54 -0700 (PDT)
X-Received: by 2002:a05:6000:2999:10b0:488:654b:ccd8 with SMTP id
 ffacd0b85a97d-48e3eb4685cmr12314759f8f.6.1793098013516; 
 Tue, 27 Oct 2026 03:46:53 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3bdbsm18090388f8f.19.2026.10.27.03.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 03:46:52 -0700 (PDT)
Date: Tue, 27 Oct 2026 06:46:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Weqaar Janjua <weqaar.janjua@packetfive.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, peter.maydell@linaro.org,
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com,
 pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com,
 marcel.apfelbaum@gmail.com
Subject: Re: [PATCH v3 0/6] hw: Add Cnuas virtual devices
Message-ID: <20261027063724-mutt-send-email-mst@kernel.org>
References: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
 <20261016153247.1815153-1-weqaar.janjua@packetfive.com>
 <20261027080746.2468700-1-weqaar.janjua@packetfive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027080746.2468700-1-weqaar.janjua@packetfive.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 08:07:44AM +0000, Weqaar Janjua wrote:
> Hi,
> 
> Ping.
> 
> Patches 1 and 4 (PCI IDs) have Gerd's Reviewed-by. Patches 2, 3, 5
> and 6 (CnuasNIC/CnuasGPU/dev models/qtests) are pending review.
> 
> https://lore.kernel.org/qemu-devel/20260929202358.725310-1-weqaar.janjua@packetfive.com/
> 
> @Michael, @Jason:
> Would one of you please be willing to take this series through your 
> tree once it is reviewed, or could you suggest who should? I am happy 
> to rework anything needed, and I understand this may now target the 
> next release given the upcoming soft freeze.
> 
> Thanks, appreciated!
> 
> Weqaar

Thanks for the patches!

Sorry I can merge if someone reviews but I just can't take on reviewing
a new device right now, I'm buried under AI security reports as it is.

I appreciate that you listed yourself as the sole maintainer but you are
a first time contributor.

Maybe Jason can review. Try poking other net device maintainers.
Maybe rdma migration guys? if this is useful to test
qemu rdma migration then suddenly you have users within the community.

Indeed, next release.

Thanks!

-- 
MST


