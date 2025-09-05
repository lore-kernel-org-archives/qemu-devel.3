Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ED3CA1010
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 17:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuaZF-0004r6-Q7; Fri, 05 Sep 2025 13:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uuaZ0-0004pR-QO
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 13:49:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uuaYp-0000ll-PT
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 13:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757094549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zc/ajDUuJDrcMGD8BS6x8rKKjj+4v6vcCVK/3cz7bls=;
 b=Wa9t5KVwl1QUK8pKK5obikmakSuEAeRgRKLpAYg48K3pyB+0cZDgsPfqly/ZIdUiEEVfi3
 Qm6NE/27lR3eCqIfhukvgcroM5jnUfOSbn1YvEMCnMBbI4CKbAMpqM+4BRykcbhBZVzCEU
 5Yh/jG8W6AGK13Zvd4lFJFdom2M3htc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-wMnUBFIMPyWxsMX5n0GUUQ-1; Fri, 05 Sep 2025 13:49:08 -0400
X-MC-Unique: wMnUBFIMPyWxsMX5n0GUUQ-1
X-Mimecast-MFC-AGG-ID: wMnUBFIMPyWxsMX5n0GUUQ_1757094548
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7e86f8f27e1so594689485a.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 10:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757094548; x=1757699348;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zc/ajDUuJDrcMGD8BS6x8rKKjj+4v6vcCVK/3cz7bls=;
 b=jhrXJ/AW8D5mFNySvHjC+qSYh3R6NLeiEKrY5cEI6aAuJAYkpQFZo93CA5AzJG6zoY
 mVfTd8id0m23YeFC1pPcXnCVz5ZaE50fSp087pdjwksHpVVQ0v6RT+lqj0ROJaz9f1fD
 oa58fdLHF9oXIf7oqalDEA9t5TNBdHhiX3ZcJgJpwhmRymTRtTD6a5CyLrKXt9IJZB1X
 6TqFyXXnpXIp8fgYq6evTD1eqsacnO+gSHFMlnHGVmeeWkxfyHe0BmfMCrJfdVfoHKln
 E7CEdJ22UEIZlRxqOd+YKowBnptAziKms/dWyamCg0HHUNWWS1sdLqUTkHMjLnqjKYo2
 Hd6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB/YlBcjeqK3gwMN/i8lEHYP1EYsfZsY3jI3EQ6sJ1AiusVTyH8OKzsc2f9NPr9u/KvQsJyrpLQMxg@nongnu.org
X-Gm-Message-State: AOJu0Yz+Lt7+f/nbznRGG50p9GAkSm4BRRZJ8gN5cgqdSrE/2+S4d6Wm
 N7Xx2ZL6exKqGpja7a5WHBJqS8ulHIzFrFJUmPfRlX2gIFcnhrzNmViBuFXip6UceHAp+S4Izd4
 lR9ZHOE1unJ2AQC13K3SQgvHg2G7368KNmn+TXQrk8SpjGKUYZJ5CGpQm
X-Gm-Gg: ASbGncsN23FKyUO69gPIaCp0lHeE8QW2fWpBw7DKSQIye2ceLLgTwD+dSjyEGlrv38K
 iuNKzVI6eV1ZfV3Uf0oTkWMyCIA2gkUEw496dntduXV7ehsmt/hAZehT4ZkmGHMokhyEdNSAJEs
 P9F6nX3vP+i+hWDKlaRvY8wvxO3zEQOLkZVXew1LWEd/cVE3HYt0IqfhpId5ALs+blinmXynOfG
 fXCgzV43d3H5hJ2JfzWsvA4t3B56VXCmPh4bc485uHpPCf5C42vg9e12SRbAvrrDca5dCxpJANq
 e9o69Egv0nPTakisnSveioEqVy1Udq+x
X-Received: by 2002:a05:620a:1a18:b0:80a:407a:d64d with SMTP id
 af79cd13be357-8109be46779mr579263185a.30.1757094547737; 
 Fri, 05 Sep 2025 10:49:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVIz5Q6eBjPHCQa899QEK5T/ytDvinA4bY2EPdst+w0MfjHXJ+7mEJbTlXqdhsVUyjqX7S7Q==
X-Received: by 2002:a05:620a:1a18:b0:80a:407a:d64d with SMTP id
 af79cd13be357-8109be46779mr579259585a.30.1757094547332; 
 Fri, 05 Sep 2025 10:49:07 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b48f635cbesm50832661cf.5.2025.09.05.10.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 10:49:06 -0700 (PDT)
Date: Fri, 5 Sep 2025 13:48:54 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V3 0/9] Live update: cpr-exec
Message-ID: <aLsihr0-Y3pynmxe@x1.local>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <aLsUQWjW8gyZjySs@x1.local> <aLsZMXHDc4uKMkyx@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLsZMXHDc4uKMkyx@gallifrey>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Fri, Sep 05, 2025 at 05:09:05PM +0000, Dr. David Alan Gilbert wrote:
> k8s used to find it very hard to change the amount of memory allocated to a
> container after launch (although I heard that's getting fixed); so you'd
> need more excess at the start even if your peek during hand over is only
> very short.

When kubevirt will need to support cpr, it needs to do live migration as
usual, normally by creating a separate container to put dest QEMU.  So the
hope is there's no need to change the memory setup.

I think it's not yet possible to start two QEMUs in one container after
all, because QEMU, in case of kubevirt, is always paired with a libvirt
instance. And AFAICT libvirt still doesn't support two instances appear in
the same container..  So another container should be required to trigger a
live migration, for CPR or not.

PS: I never fully understood why that's a challenge btw, especially on mem
growing not shrinking.  For CPU resources we have the same issue that
container cannot easily hot plug CPU resources into one container, that
made multifd almost useless for kubevirt when people use dedicated CPU
topology, it means all multifd threads will be run either on one physical
core (together with all the rest of QEMU mgmt threads, like main thread),
or directly run on vCPU threads which is even worse..

-- 
Peter Xu


