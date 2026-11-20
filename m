Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51087606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=drPqDeG6;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qvG6PsEi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUOJF-0000Cd-Fi; Fri, 20 Nov 2026 08:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUOJ7-0000Ap-Cr
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 08:05:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUOJ5-0003O9-N5
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 08:05:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795179934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XYxo9rZBJIm0Lv8cLpDsNblmw49VbinlqjFQCuDDfso=;
 b=drPqDeG6/Rp223FJTsPD+JB3kmfiI3YMStN6rrD/fviTbHaOMUtH44ntSQvNoPmx6SKcOf
 Oj7MLfinm99secAzXrieg4iM3LoyWwz0BhUhIQe5kvOZvrkdvwxg8C8oRJf3iQSr2XDgS0
 v4MLJ5irQ4oU6/nopys+Jqeuo8eyuvM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-DhAjqYWiO1O5hLVAOiekkA-1; Fri, 20 Nov 2026 13:05:29 +0000
X-MC-Unique: DhAjqYWiO1O5hLVAOiekkA-1
X-Mimecast-MFC-AGG-ID: DhAjqYWiO1O5hLVAOiekkA_1795179929
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5363763b556so18519571cf.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 05:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795179929; x=1795784729; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XYxo9rZBJIm0Lv8cLpDsNblmw49VbinlqjFQCuDDfso=;
 b=qvG6PsEiXuGfgmy5VsE3mHWHWLYOIDNze2qc5a43s/6dS49X1Iwq4O2B1iENmK+yNN
 /2t/P2HM5B8zh7r5zCGL19MrPK0QaMpPJpDLv4Nt2eUjbWxhNbxsBsuu0S/XKDWGQofd
 gBFfVVVD0R9NM7UgSrdt1QlpK435KbbsHOGovHuJxX3dhaz/15VWwJPpwOp+a3KERGfc
 DbLWKBVpnXl+6OZkNk6lAi3603xE7JN4mJCK2FQcuNYs5rJlkpXALvZEJkGaxfa0R7Xx
 JAUFgXFQbKncoogGtOL7skIE8/VWp5BivEXgtvfoV2uU7hn3AemmFcQ0dPbbiwxKcwTO
 Dg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795179929; x=1795784729;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XYxo9rZBJIm0Lv8cLpDsNblmw49VbinlqjFQCuDDfso=;
 b=KSLYlk09wm28WGZDj/8iemplmLdILTc89yVTxJp8L0oatHsfYAFWBEQse2mdIvRw8/
 QZi1iFX8BgCPXQHCEK6RF4RzUNynVKcWa03cC2d0y/l7o4a99yTv7oNju+7nmB/3jaHH
 HWfE5wq8edcD04sh8SuwG1Lt0a4AH0LbOXObQ3FWQFFztjFyNfw6g2DSbILr4kqzMTcj
 Tron8VsZe/BGvyedWkY0VEjcMLVQqS4qdwCXEqkME0C6TDaTxWwo9Vur32rUF0H0Qek0
 bApXfEw1h+FcbVpL18GdaWFH7fCU2vBaRFeRfxOShOV2IDdr42Z1QEeyK9Qj5742AUNy
 vIqQ==
X-Gm-Message-State: APuU4Z8KWc8kruusFiIaE+wmP0y63WWGm1P3LqtBDEAWnNj2sjZ3hsaP
 LKLM9adzkO0qPzyitJKweDBxoN8mXPMgROh8TgdOwZLBuPYIQ1mahHbt+RW2PMa7pbWRAN26uhj
 U1uj5ZDMkibi3vDjsa9RHpkZdVisFKCvYWRNyIIC+stL/4xEA797MTXtZ
X-Gm-Gg: AZFdTZdTti6fKB4tY9dGBnDGnFlGMx6ZcVIe8mjnqW9tfVzsSEZhzk2zkiosOy6gJMT
 3s6SBYScfZZQpiahB0AppbIgxvJJmkFKkLtz2M2pJp/Bk4X/H9FBmjBvxgpW3AgmGveQlV2BhsV
 p9w8/d7WJhEYryzTuU78NXeAhqL2rYo/s5kLEq0kCokwENO/X9yT5jRmM0XZh5uLvL2SRaTxbpx
 Z7ZevuJ9+ca50opF+z0fNFJIHdhN3dDEL0O6mgYBaoCjTvdIZumagZHZe6tkQV2JvuJZzbH5+7d
 6dn3f7xxH01iAmgJO6PuDBXX4RnTZGbNY10bZlHOfidFfAadopVbNkeBsiej3D2FrZHcHow16vk
 mYqrkbCBLbfnp51Xh8b2l4yuWcuq/NwwDFaEfI8gi2zB0
X-Received: by 2002:a05:622a:5d1:b0:55d:2dd1:48c8 with SMTP id
 d75a77b69052e-55d76add55emr50867581cf.67.1795179928588; 
 Fri, 20 Nov 2026 05:05:28 -0800 (PST)
X-Received: by 2002:a05:622a:5d1:b0:55d:2dd1:48c8 with SMTP id
 d75a77b69052e-55d76add55emr50866871cf.67.1795179928014; 
 Fri, 20 Nov 2026 05:05:28 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d784517casm22240561cf.3.2026.11.20.05.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 05:05:27 -0800 (PST)
Date: Fri, 20 Nov 2026 08:05:26 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Fabiano Rosas <farosas@suse.de>
Subject: Re: VMSTATE_VALIDATE failures on outbound migration
Message-ID: <awBFlnLKtKzMKWoQ@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <CAFEAcA-iAdTGc0M4ZV5LYXscVVj2oEr7FN+Ac=oBo2_oxuygzg@mail.gmail.com>
 <av8k8oiG8lRh5bVI@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA_8EAke9-dk-2HfkQ5BJyuODtcSK+DUcmYKRSKgEf=Wnw@mail.gmail.com>
 <av9D4pVMM989xNcE@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA8UWw+CpaS8wyy0A_MSeXhJ3NzJGcLm-iHkzmw5t9Cd_w@mail.gmail.com>
 <av9be5IWLpQJu-F_@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA-fmyi6iWBbXmUUWkf=-9duEySHyPE_ELz8FLgcrhcGAQ@mail.gmail.com>
 <awA9gHtzrNgyWWkc@zhexu-thinkpadt14gen5.rmtcaon.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <awA9gHtzrNgyWWkc@zhexu-thinkpadt14gen5.rmtcaon.csb>
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

On Fri, Nov 20, 2026 at 07:30:56AM -0500, Peter Xu wrote:
> > I don't think "validate, and it happens that I need a custom
> > function to do that" should be this much more complicated than
> > "validate using one of the standard checks like
> > VMSTATE_UINT16_EQUAL".

And I forgot to comment on these _EQUAL macros: I don't think they're
useful either.  If we assert them equal, we should IMHO not migrate them..

QEMU maintains too many things internally assuming both sides match.  If we
keep adding these EQUAL fields to migrate just to say they're equal, then
our downtime can grow from 100ms to 500ms with totally no reason to.

I'll leave that for another day, but IMHO those can really be replaced with
NOT_USED.  Something like "num < max" check still makes sense, but ideally,
all "this equals to that" fields should not be on the wire at all, IMO.

Thanks,

-- 
Peter Xu


