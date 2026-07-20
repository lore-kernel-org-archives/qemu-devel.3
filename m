Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D13C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlqSB-0004XC-3B; Mon, 20 Jul 2026 12:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlqSA-0004WT-9h
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:02:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlqS7-0005yJ-Hz
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784563366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XRZa9+oiAprZlt+O1KJQUffJUxIioWtyM/sis+hPzso=;
 b=ZAO2YgtZvYD/xgvuaOYlIYPsYl55//DeFLZmAe5tlUd3Y/jOLqS5JMNYAN85XWr+a38Fgd
 pT7LQl5s8dMveq1TzMajKTv6M29eP8WhoT4o6eml2hOrBgYXfw9MIgY8P6lR08qFaXrE5v
 xsV7f4Di7taFsNeK2wgqPCClqwftTL4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-5W61zwIoM5-DurcBaujdQQ-1; Mon, 20 Jul 2026 12:02:45 -0400
X-MC-Unique: 5W61zwIoM5-DurcBaujdQQ-1
X-Mimecast-MFC-AGG-ID: 5W61zwIoM5-DurcBaujdQQ_1784563365
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0408254aso91874631cf.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 09:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784563365; x=1785168165; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XRZa9+oiAprZlt+O1KJQUffJUxIioWtyM/sis+hPzso=;
 b=JfM4gijhABfLSZaWUDjcLzK3n20YviE8xOD+TDFEogQuxYQ8ghdr/chGKiAeqpP8EK
 oczt/98e64FNBnbyaRu5ShpP2OtLz7XLEoFt5+zSmNqC89cveneXimsTxjyuwR2AFM50
 HbEIatcLwOiB6f0gIiv5yhB0RidujHh1WBc2a60RpnzwDwP9hev2cirfguyQSuzZIx7t
 MqtAw0WKcSV6RvfxN9GsehakbUwk+S244FAOruWt+KsRIhuyFA9Koq/zW7VLrJt5fHhX
 1dkr//MIvah8wZM/VmG3MWZIU/oW5/kZKzCMATyVNcCumtmCdSn+CAp+XH5l4uxV/xu/
 bCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784563365; x=1785168165;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XRZa9+oiAprZlt+O1KJQUffJUxIioWtyM/sis+hPzso=;
 b=NVXo6oeAtctVS54cTDINRLKB2ncCCsE3wwsGpV2DHaVdStByvLbRmmey8Ij7lbENHl
 y+b0PW97p2eoE4QtSZEPDL0UZOzInR3KrUNu5t4EErvbkS1ecGHNJ8t1VhNAIHTaFq5E
 km0opieZLzgvR96H87tIezL91x3qnOqZlCyaGsnD4W4frE69zqw6z3rvN8FE8jBjhzaO
 1JqtGs2TEGV3hVmdZGTPeBbhWjl4L718ksK5vIs4JuJC1QdHP9c+NldRfbWGR/+BtMsQ
 wUQkQj0gzZoSnO0iB1gXZPzs0PCpYfI5FW2dCwYRj1nexnZ902Ruixt3bLt6H/54lgu/
 4lVw==
X-Gm-Message-State: AOJu0YxPKdCyGi8neBUsgeuU8gH6pN5H5etcIZf26Yvtbuj40z1FN5DF
 asVmG7agtq+EVlc73LQW6mpX1alfRtMabthnQ+OpZAFMvPSYV99NYUdOld11YjLZz6ypmjW9VZ+
 OOQWbyRJCfeNGJxfm8zz0V+5U1j09cKHLqQmphLK78rc9fEX6gFvr+XhD
X-Gm-Gg: AfdE7ck61N1iAlNWgYFuMmI9H88anyld6LWhd+wXBerv3cLp0hky8oPTS5OL28OBYfg
 N6mxlyoc0kClsURv8Fb8SpqaIHDH0SPn7LpSBsXIfoWny8XJDUZEFHppsb6AUG8ExVr0bdO7tm9
 5SakpiAJprluuEBSNrtAhb4duwy1bW4K9rU4oxtkkdQGoE1Jh3RaQKnuxf59OgLOwuUjsP9gEPq
 XIEtGyf4j8ylBMAq9WqeZ9OZDr+UQPMCCmqkCOSnd2y9+k3ZILg3uo49KQHjHurLec5iZ0ISSTz
 u2Mip2CWzuVPlALdbvarbt4rJdH3ymUhahtlw2JGjJ0Az50mGFlsDZMkb2QusvAIAP34
X-Received: by 2002:ac8:7f04:0:b0:517:5ed7:d28f with SMTP id
 d75a77b69052e-5212b63ae94mr137104241cf.25.1784563364791; 
 Mon, 20 Jul 2026 09:02:44 -0700 (PDT)
X-Received: by 2002:ac8:7f04:0:b0:517:5ed7:d28f with SMTP id
 d75a77b69052e-5212b63ae94mr137103501cf.25.1784563364094; 
 Mon, 20 Jul 2026 09:02:44 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-521502b92acsm81088431cf.30.2026.07.20.09.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:02:43 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:02:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v3 04/11] migration: Use file_bmap for RAMBlock during
 incoming file load
Message-ID: <al5Gl3GIIPHWqwFo@x1.local>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
 <20260714141547.1268000-5-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714141547.1268000-5-aadeshveer07@gmail.com>
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 14, 2026 at 07:45:40PM +0530, Aadeshveer Singh wrote:
> Replace the temporary bitmap with the existing file_bmap attribute of
> the RAMBlock. This acts as a preparatory change for the upcoming fast
> snapshot load feature.
> 
> Reusing this bitmap allows the destination to track page types during
> a postcopy load, enabling faster, direct placement of zero pages.
> 
> Since file_bmap is currently only utilized during the migration save
> phase, it can be safely repurposed during the load phase without
> introducing conflicts.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


