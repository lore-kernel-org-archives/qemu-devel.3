Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C706C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 14:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkPNz-0000GR-An; Wed, 13 Mar 2024 10:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rkPNv-0000Dh-9r
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 10:15:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rkPNs-0000Vi-52
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 10:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710339306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xLlkr+NmzKKvtT5Ck0eawLXQqUHhj2ee2z2zaBJqjM=;
 b=QyDELi/D2E048bkun14k3mBV6P6LgHJydCB1u68XLGVWI4J9+JKvHrpJ2YFKJANSO0ReFO
 k9stmVNnZdtNWGlrveToLdioDGoq8F8SNoLEYELRtWaoRYnvI+rnE+rzruAonAsRVf2E40
 kzZTm91mSnrtAAwkkVNySp9EmjnOtwQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-m-4i04QwPcqHCusmPv7ppw-1; Wed, 13 Mar 2024 10:15:05 -0400
X-MC-Unique: m-4i04QwPcqHCusmPv7ppw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4131eaecb4aso23441955e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 07:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710339304; x=1710944104;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3xLlkr+NmzKKvtT5Ck0eawLXQqUHhj2ee2z2zaBJqjM=;
 b=PCr9XkC/MqSY8BtJ5yOFG6j8gHOgu8ramsTZCiHD9X0ZqcKV4vXDtF37wMsd6L2B0J
 3lFYibBrDP3oGT9QJa9xdbxBSh95ryBvZ3I9DlxuYAHnn5cuBJyWNG5dSNU6vEZGtxlV
 /yNoj5NxstbJUdVapCqlE5xvqtAMbWxmGGb8ie96eMf9hkPknK2OD9bsla/3A1KKGwnr
 hEPt/paHIDoCvNjBYVK1qeXMZntvhj1pCbyf3Xs1J9kfTqh/U/xGHobQ0rVW2haz2yWM
 I9e3tPLKkfZSwkzRMFqg3PqEBxAuUGriE/arAfPSiJyvSpmf9VZTJMAKRU3YbONISlo+
 Lv0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWilhkL2l34iu1tG0KKsKtb0EyKG1ilqtVBuKXcUdUS/ALXWEkUCWrnl/SZX9A8oUmEEA5neDmzezXcIrtcvjQaj8jCr3g=
X-Gm-Message-State: AOJu0Yxf10eL4bAZvkCl6FI19cEuMJMnIAma+QbNAzFfySAmcwX0oA4a
 E2q9K0UeaLXroNb3xQuddbdCEE8KODUUFxqnESPmkzjGoMOMEzDo47NDzRv8IEHDgLbZ+wKfYvJ
 TGPsMFiZLZ3jDVRkh8XTh+E4Y5ayPmcgc7GhLj2rUvo+oHvBOWJoB
X-Received: by 2002:a05:600c:45c9:b0:413:2f9c:99de with SMTP id
 s9-20020a05600c45c900b004132f9c99demr89229wmo.8.1710339303917; 
 Wed, 13 Mar 2024 07:15:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuhjjiHyD5pwXLanBqXCkMj6iOvhPO9ZU3PF5BkvaAUL0s6T76CPnbH/TPyZ/L+DLjeVI7eg==
X-Received: by 2002:a05:600c:45c9:b0:413:2f9c:99de with SMTP id
 s9-20020a05600c45c900b004132f9c99demr89204wmo.8.1710339303468; 
 Wed, 13 Mar 2024 07:15:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:530f:c053:4ab2:f786?
 ([2a01:e0a:9e2:9000:530f:c053:4ab2:f786])
 by smtp.gmail.com with ESMTPSA id
 fj14-20020a05600c0c8e00b00413385ec7e6sm2426927wmb.47.2024.03.13.07.15.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 07:15:02 -0700 (PDT)
Message-ID: <481a0513-67da-4b5c-a46d-779842f046c0@redhat.com>
Date: Wed, 13 Mar 2024 15:15:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: cpr-reboot documentation
Content-Language: en-US, fr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1710338119-330923-1-git-send-email-steven.sistare@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <1710338119-330923-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/13/24 14:55, Steve Sistare wrote:
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

This would be good to have for 9.0. Anyhow,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   docs/devel/migration/CPR.rst      | 147 ++++++++++++++++++++++++++++++++++++++
>   docs/devel/migration/features.rst |   1 +
>   2 files changed, 148 insertions(+)
>   create mode 100644 docs/devel/migration/CPR.rst
> 
> diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
> new file mode 100644
> index 0000000..63c3647
> --- /dev/null
> +++ b/docs/devel/migration/CPR.rst
> @@ -0,0 +1,147 @@
> +CheckPoint and Restart (CPR)
> +============================
> +
> +CPR is the umbrella name for a set of migration modes in which the
> +VM is migrated to a new QEMU instance on the same host.  It is
> +intended for use when the goal is to update host software components
> +that run the VM, such as QEMU or even the host kernel.  At this time,
> +cpr-reboot is the only available mode.
> +
> +Because QEMU is restarted on the same host, with access to the same
> +local devices, CPR is allowed in certain cases where normal migration
> +would be blocked.  However, the user must not modify the contents of
> +guest block devices between quitting old QEMU and starting new QEMU.
> +
> +CPR unconditionally stops VM execution before memory is saved, and
> +thus does not depend on any form of dirty page tracking.
> +
> +cpr-reboot mode
> +---------------
> +
> +In this mode, QEMU stops the VM, and writes VM state to the migration
> +URI, which will typically be a file.  After quitting QEMU, the user
> +resumes by running QEMU with the ``-incoming`` option.  Because the
> +old and new QEMU instances are not active concurrently, the URI cannot
> +be a type that streams data from one instance to the other.
> +
> +Guest RAM can be saved in place if backed by shared memory, or can be
> +copied to a file.  The former is more efficient and is therefore
> +preferred.
> +
> +After state and memory are saved, the user may update userland host
> +software before restarting QEMU and resuming the VM.  Further, if
> +the RAM is backed by persistent shared memory, such as a DAX device,
> +then the user may reboot to a new host kernel before restarting QEMU.
> +
> +This mode supports VFIO devices provided the user first puts the
> +guest in the suspended runstate, such as by issuing the
> +``guest-suspend-ram`` command to the QEMU guest agent.  The agent
> +must be pre-installed in the guest, and the guest must support
> +suspend to RAM.  Beware that suspension can take a few seconds, so
> +the user should poll to see the suspended state before proceeding
> +with the CPR operation.
> +
> +Usage
> +^^^^^
> +
> +It is recommended that guest RAM be backed with some type of shared
> +memory, such as ``memory-backend-file,share=on``, and that the
> +``x-ignore-shared`` capability be set.  This combination allows memory
> +to be saved in place.  Otherwise, after QEMU stops the VM, all guest
> +RAM is copied to the migration URI.
> +
> +Outgoing:
> +  * Set the migration mode parameter to ``cpr-reboot``.
> +  * Set the ``x-ignore-shared`` capability if desired.
> +  * Issue the ``migrate`` command.  It is recommended the the URI be a
> +    ``file`` type, but one can use other types such as ``exec``,
> +    provided the command captures all the data from the outgoing side,
> +    and provides all the data to the incoming side.
> +  * Quit when QEMU reaches the postmigrate state.
> +
> +Incoming:
> +  * Start QEMU with the ``-incoming defer`` option.
> +  * Set the migration mode parameter to ``cpr-reboot``.
> +  * Set the ``x-ignore-shared`` capability if desired.
> +  * Issue the ``migrate-incoming`` command.
> +  * If the VM was running when the outgoing ``migrate`` command was
> +    issued, then QEMU automatically resumes VM execution.
> +
> +Example 1
> +^^^^^^^^^
> +::
> +
> +  # qemu-kvm -monitor stdio
> +  -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/dax0.0,align=2M,share=on -m 4G
> +  ...
> +
> +  (qemu) info status
> +  VM status: running
> +  (qemu) migrate_set_parameter mode cpr-reboot
> +  (qemu) migrate_set_capability x-ignore-shared on
> +  (qemu) migrate -d file:vm.state
> +  (qemu) info status
> +  VM status: paused (postmigrate)
> +  (qemu) quit
> +
> +  ### optionally update kernel and reboot
> +  # systemctl kexec
> +  kexec_core: Starting new kernel
> +  ...
> +
> +  # qemu-kvm ... -incoming defer
> +  (qemu) info status
> +  VM status: paused (inmigrate)
> +  (qemu) migrate_set_parameter mode cpr-reboot
> +  (qemu) migrate_set_capability x-ignore-shared on
> +  (qemu) migrate_incoming file:vm.state
> +  (qemu) info status
> +  VM status: running
> +
> +Example 2: VFIO
> +^^^^^^^^^^^^^^^
> +::
> +
> +  # qemu-kvm -monitor stdio
> +  -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/dax0.0,align=2M,share=on -m 4G
> +  -device vfio-pci, ...
> +  -chardev socket,id=qga0,path=qga.sock,server=on,wait=off
> +  -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0
> +  ...
> +
> +  (qemu) info status
> +  VM status: running
> +
> +  # echo '{"execute":"guest-suspend-ram"}' | ncat --send-only -U qga.sock
> +
> +  (qemu) info status
> +  VM status: paused (suspended)
> +  (qemu) migrate_set_parameter mode cpr-reboot
> +  (qemu) migrate_set_capability x-ignore-shared on
> +  (qemu) migrate -d file:vm.state
> +  (qemu) info status
> +  VM status: paused (postmigrate)
> +  (qemu) quit
> +
> +  ### optionally update kernel and reboot
> +  # systemctl kexec
> +  kexec_core: Starting new kernel
> +  ...
> +
> +  # qemu-kvm ... -incoming defer
> +  (qemu) info status
> +  VM status: paused (inmigrate)
> +  (qemu) migrate_set_parameter mode cpr-reboot
> +  (qemu) migrate_set_capability x-ignore-shared on
> +  (qemu) migrate_incoming file:vm.state
> +  (qemu) info status
> +  VM status: paused (suspended)
> +  (qemu) system_wakeup
> +  (qemu) info status
> +  VM status: running
> +
> +Caveats
> +^^^^^^^
> +
> +cpr-reboot mode may not be used with postcopy, background-snapshot,
> +or COLO.
> diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
> index 9d1abd2..d5ca7b8 100644
> --- a/docs/devel/migration/features.rst
> +++ b/docs/devel/migration/features.rst
> @@ -11,3 +11,4 @@ Migration has plenty of features to support different use cases.
>      vfio
>      virtio
>      mapped-ram
> +   CPR


