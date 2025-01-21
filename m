Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5253CC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 21:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taLLv-0002mb-VT; Tue, 21 Jan 2025 16:00:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1taLLu-0002mB-EM
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 16:00:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1taLLs-0007FI-Sm
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 16:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737493198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6J7gV8pbKI/HEoHJpV5G2tPVyfFbSww6v2htxofYJWU=;
 b=E0VRsz5CBVwC0oYJtwL6MjXSEzBvQJPH777iWD/AE50FDU7moNh8UFM+jM2369zPEaKEuu
 Yvm+rm44pCiKNNSy5C6kpOyXOKixnBXIoYFYObaPNvOALTXGXAi5jl3i9+hNtSRoZj87+M
 MzLG3DAk3gTRrYNvlhwRebMOW76l8ug=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-cpLf4IT2PgeImIB6yJtNzw-1; Tue, 21 Jan 2025 15:59:57 -0500
X-MC-Unique: cpLf4IT2PgeImIB6yJtNzw-1
X-Mimecast-MFC-AGG-ID: cpLf4IT2PgeImIB6yJtNzw
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-468f80df8caso112443431cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 12:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737493197; x=1738097997;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6J7gV8pbKI/HEoHJpV5G2tPVyfFbSww6v2htxofYJWU=;
 b=wn9pAJ4on7dBNsA7spEnEH7nOI68KoV9nz3toT7eVy8VCYQebqGj12ZEAFhIozhKrH
 QWXHUZ1POuUo1Qa7og5kWXtaQW5H1Xn41+iqxRMAfuxgJH5HNM6RPOZ6TIg3RuNMIEWD
 q8IaZXMaBgOIWJv83vRn2Nm3kMtQc+OPf4WEJoUrPMa3EYRhsg+hE+kLD+qEZ3v7sBw+
 04zJrD2r6HddlY+4mU8AXmDz6lrgvXP+F7NeF1AlPTYv6Hfn/YG7vGIiG/jz6JegUbEr
 bDIARS+qaNCtFsN//QB0+GnEGToxd+sGoCTHuaaVAzhihOX8MxyNhGMa8/Y20D6ZnnP9
 5ukg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCgU8knpyuQVx//EHQ+57bMtHxGvXX29RNxNcC/YWta8psOrJ6/GJNLceUTugpODg7RvaMTaIXZjkF@nongnu.org
X-Gm-Message-State: AOJu0Yx+XdCiqhyJrInn48NmebD9q8QerZjj9EzXcEG51sHa1EvCJqdh
 AuJCULi9lXZ8H7aV+6CtQWho+rOAfXt+JiXxzbuE6w1+r/TpAIO0PRhUwW+hGJKwZ192n4wWs27
 BwM/lPZWrHj7b2QNBBOo/45Q29fICsRTyMxhfzV2LS0RL2v1zzIQt
X-Gm-Gg: ASbGncuQyRzVvIKB/IToRqKS8fk/Q+zh6ClXF/GaZZ/996buO+IN8ata65qT/BluZGx
 nxU1VqP5jWWYDu3P9dh2kUt95EyZZhLOnlJpIBKaYs+BtMLuBpAA3azqyGkmk4j2q+qq3/AyOtU
 VgoY6tiGOJY0Ar31Byml6z1QqQ5AXKyYz06O5gldN9eEleTI7pFzvrKx4Nny8zlgDNZtk0UMWqH
 R5OqRl+N1lJYZeFUWeAF9sz7jH1dW/9Z4xjMShLWTKRFW5qmA7IxtpMpFNixL0YUkO9kAln7nK9
 +rBT71l/LJUHWnaB+NkWRJEB+voubqw=
X-Received: by 2002:ac8:57c2:0:b0:467:774b:f04b with SMTP id
 d75a77b69052e-46e12a93d06mr276678701cf.22.1737493197119; 
 Tue, 21 Jan 2025 12:59:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEn1pBbzR5EeQZWdv4Re19JYbM8VMdhJer89dpcnaMlygc/VA0W2DHABOVvJv5pcI6iVJ8Knw==
X-Received: by 2002:ac8:57c2:0:b0:467:774b:f04b with SMTP id
 d75a77b69052e-46e12a93d06mr276678471cf.22.1737493196858; 
 Tue, 21 Jan 2025 12:59:56 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e1030dffesm57967601cf.41.2025.01.21.12.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 12:59:56 -0800 (PST)
Date: Tue, 21 Jan 2025 15:59:53 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
Subject: Re: [PATCH v3 07/49] HostMem: Add mechanism to opt in kvm guest
 memfd via MachineState
Message-ID: <Z5AKycFhAX523qzl@x1n>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-8-michael.roth@amd.com>
 <Z4_b3Lrpbnyzyros@x1n>
 <fa29f4ef-f67d-44d7-93f0-753437cf12cb@redhat.com>
 <Z5AB3SlwRYo19dOa@x1n>
 <bc0b4372-d8ca-4d5c-aee8-6e2521ebb2ec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc0b4372-d8ca-4d5c-aee8-6e2521ebb2ec@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jan 21, 2025 at 09:41:55PM +0100, David Hildenbrand wrote:
> So far my understanding is that Google that does shared+private guest_memfd
> kernel part won't be working on QEMU patches. I raised that to our
> management recently, that this would be a good project for RH to focus on.
> 
> I am not aware of real implementations of the guest_memfd backend (yet).

I see, thanks, those are pretty useful information to me.

I think I have a rough picture now.  Since I've already had some patches
going that direction, I'll give it a shot.  I'll keep you updated if I get
something.

-- 
Peter Xu


