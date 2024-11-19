Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A715D6C29A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 20:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDVBo-0000gU-Cz; Tue, 19 Nov 2024 15:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDVBm-0000g6-FI
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 15:51:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDVBj-0001eH-Oz
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 15:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732049466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bnwDO+2E0ozrFSFKPmR/aTpCRDCpIaHkckrnx/ze9R0=;
 b=RNTjryRSJYhAiE81e6X8Gtn2LfFx6tq46gmjpT2ktX5Y2zaF/SMAjlKuhmEcWpxK/reX+5
 P7yFe6RS8IgyiebV/y/S/OMYHqFUn4ohIAOARa1Hs/PrRklySsg+kPHwd14w4W3WdpEPnC
 IAEd6w/vW162nKTZDbhsJcj5nqAHKVI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-MbgmdkfpPrGmmcSkZWCrgg-1; Tue, 19 Nov 2024 15:51:05 -0500
X-MC-Unique: MbgmdkfpPrGmmcSkZWCrgg-1
X-Mimecast-MFC-AGG-ID: MbgmdkfpPrGmmcSkZWCrgg
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-6eb0a1d0216so21536897b3.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 12:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732049464; x=1732654264;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bnwDO+2E0ozrFSFKPmR/aTpCRDCpIaHkckrnx/ze9R0=;
 b=rttyQCjPc4ZxDGFB7OSAmZiCoW6lD17+f4qSjViXg6an9/uOmZRAz9nEX0NJ9nX30h
 2ROvr5WYDlrfHup5Xxz1rx6bfViXec7egj1OvoRimm+XbvGv7mrnj5m1Wdmu4UxrsCuy
 VoWR/4iQVsGq8Cl6ohvzRK2gyxnpFrDnn8WCM0vcob9zQlIgSTOIWvERKVdbFkk7hw3H
 3h61I8IbKGfue5ilG3h+XwMZNH2vWgr3l+JsdPWgLppT43zVMcbeGNolZW2iEwf08RwK
 zQQkoZ5kg7NL1aagaRpd05KdIMdpiTEEwoUJr48NR96ePg3SqyGSMSP5U4gqcWdkHY9o
 tSWw==
X-Gm-Message-State: AOJu0YwU0zknmOfrU2fZz2ttLJPTRjZ3Dve5iVBKfhXeT6W2Rwjp+/Db
 zewmDYP1KmUm40GxLfeW7V0SJgu/5wbFUbsKbeBf42vVZ65kgjvWBGZx6behvwFYaUducPe8Ayo
 xw6DaEIHMCUFbHcu6rkm1PqLxUMWxkNnhNbukk4sR0UDolzqWpvEE
X-Received: by 2002:a05:690c:380e:b0:6e7:e22b:fb80 with SMTP id
 00721157ae682-6eebd1534f1mr3601207b3.19.1732049464752; 
 Tue, 19 Nov 2024 12:51:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjx4WIUFg6gh93YHdddYSZtWpnzXP+0SGvgIE2fbphsKDMw+ONiQ2sM0tYdQMGqqhiqqqMXA==
X-Received: by 2002:a05:690c:380e:b0:6e7:e22b:fb80 with SMTP id
 00721157ae682-6eebd1534f1mr3601027b3.19.1732049464506; 
 Tue, 19 Nov 2024 12:51:04 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d438133d34sm452616d6.113.2024.11.19.12.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 12:51:04 -0800 (PST)
Date: Tue, 19 Nov 2024 15:51:01 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V3 11/16] migration: cpr-transfer mode
Message-ID: <Zzz6NVoJss4JdEHh@x1n>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-12-git-send-email-steven.sistare@oracle.com>
 <ZzUg9w0Kvfuleuxk@x1n>
 <51967cb2-05ec-485b-a639-8ff58d565604@oracle.com>
 <ZzZJvTldpe3D4EO5@x1n>
 <c53feba3-d448-4494-8dbf-0725a2dd8dba@oracle.com>
 <ZzzyOJT_mDh37_Py@x1n>
 <c56ffc81-b065-4dd0-ab06-eb79912dcaf7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c56ffc81-b065-4dd0-ab06-eb79912dcaf7@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 19, 2024 at 03:32:55PM -0500, Steven Sistare wrote:
> This begs the question, should we allow channels to be specified in hmp migrate
> commands and for -incoming, in a very simple way?  Like with a prefix naming
> the channel.  And eliminate the -cpr-uri argument. Examples:
> 
> (qemu) migrate -d main:tcp:0:44444,cpr:unix:cpr.sock
> 
> qemu -incoming main:tcp:0:44444,cpr:unix:cpr.sock
> qemu -incoming main:defer,cpr:unix:cpr.sock

IMHO keeping the old syntax working would still be nice to not break
scripts.  I was thinking we could simply add one more parameter for taking
cpr uri, like:

    {
        .name       = "migrate",
        .args_type  = "detach:-d,resume:-r,uri:s,cpr:s?",
        .params     = "[-d] [-r] uri [cpr_uri]",
        .help       = "migrate to URI (using -d to not wait for completion)"
		      "\n\t\t\t -r to resume a paused postcopy migration",
		      "\n\t\t\t Setup cpr_uri to migrate with cpr-transfer",
        .cmd        = hmp_migrate,
    },

-- 
Peter Xu


