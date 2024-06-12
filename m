Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96970C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 12:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHN0c-0000fi-P0; Wed, 12 Jun 2024 08:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHN0a-0000eX-Vz
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:23:21 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHN0W-00011Y-07
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:23:20 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52bc335e49aso2911219e87.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 05:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718194993; x=1718799793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Acf3Mx7S45LMuhHwPGLrXU1u+Mid4/Y1POR7Yi8ngPU=;
 b=F6tsDgBBqZPDff/Ky918vcwgb2GVeensncUUXzEF54DMCXo0+8YqQkberDD65Q2AUX
 t3kLYx3LN7yr+aBDmYcdzFQYrb3oKDjW8fvDpVRFVJe9RvR9dKNtHz6EQ0AdgRDmCBEf
 4Jlav2YIJ5h9wv0nmnGywF7Szwvv9ldyB9TyZpXSSd7gakhntUbVDowAqxPVMQhqGmtd
 EJ2FZ6HqknPHvDzAAxvU15GtR8t1Occvpdd34vOi9JmfK9SaBq4NypNFi1suOWUixVDT
 SkP/ilbHRtfMhqLmfbunR2coJb96jKsvj0IC1XtoWCcSlQxshk7kTbYUZHhT9y7IwrhV
 /yZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718194993; x=1718799793;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Acf3Mx7S45LMuhHwPGLrXU1u+Mid4/Y1POR7Yi8ngPU=;
 b=pqrZRFw5PI4qitnpoa6UrLeVeHjijHioloYttSAPdcph3AH+xzjbPzxhyc7xnE30NT
 kinynHicoUvro05uEd1tCvJf/KOSMJupjwv5PDLY6Wzu+4cPNOGw4d1wgJGcHVHys+UI
 d5GYwTZVUGUu5IPaqZ1e2WJCeWDLGr8f9dVFWrgZpbJTDTREtR5zIokmaPDqYfZFWgPs
 jIgCQawOhqjtGAqJYdTVNReBuAK+aCC2gO9CILCuxA1Z6gCwUgqcuaj30VrJLL6sfM5T
 RP4U3sJnmLPjjnj2PcaIX+xZrDYrDYBYscpPCKujR3doLCDrndiSX8zJlcO67cCrO070
 1tFQ==
X-Gm-Message-State: AOJu0Yy0n6EVVYkmCkCL3kHk4DAYeZz/PYoiT6mZI4RBUHcWw0RVlOWk
 4Dr+NJ2fGeaKxyhWGhmhtf9MWgrctsA/gH2k9lVanVtTUZOULy+ee41z1HeKlPpZ+toZP7+6cTg
 h
X-Google-Smtp-Source: AGHT+IG6b0uT356eWP1brRYMfAZKQQak0y7MNZ+PfPxXnQJSeRlo7AqFbuRrtcVVc5smK1Pgx5MH4A==
X-Received: by 2002:ac2:53a2:0:b0:52b:c1d5:949d with SMTP id
 2adb3069b0e04-52c9a3fdec7mr988649e87.54.1718194992912; 
 Wed, 12 Jun 2024 05:23:12 -0700 (PDT)
Received: from [192.168.69.100] (ram94-h02-176-184-0-172.dsl.sta.abo.bbox.fr.
 [176.184.0.172]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422874e73e8sm25796105e9.43.2024.06.12.05.23.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 05:23:12 -0700 (PDT)
Message-ID: <18739a67-84bb-4fd3-adb6-0db0f0eb7af1@linaro.org>
Date: Wed, 12 Jun 2024 14:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 21/22] qapi: Inline and remove QERR_UNSUPPORTED
 definition
To: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org
References: <20231005045041.52649-1-philmd@linaro.org>
 <20231005045041.52649-22-philmd@linaro.org> <87mswx5n63.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87mswx5n63.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Michael, Konstantin, QERR_UNSUPPORTED is only used by QGA.

Do you mind giving our maintainer's position on Markus
analysis so we can know how to proceed with this definition?

Regards,

Phil.

On 5/10/23 13:22, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Address the comment added in commit 4629ed1e98
>> ("qerror: Finally unused, clean up"), from 2015:
>>
>>    /*
>>     * These macros will go away, please don't use
>>     * in new code, and do not add new ones!
>>     */
>>
>> Mechanical transformation using:
>>
>>    $ sed -i -e 's/QERR_UNSUPPORTED/"this feature or command is not currently supported"/' \
>>      $(git grep -wl QERR_UNSUPPORTED)
>>
>> then manually removing the definition in include/qapi/qmp/qerror.h.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> RFC: Not sure what is the best way to change the comment
>>       in qga/qapi-schema.json...
>> ---
>>   qga/qapi-schema.json      |  5 +++--
>>   include/qapi/qmp/qerror.h |  3 ---
>>   qga/commands-bsd.c        |  8 +++----
>>   qga/commands-posix.c      | 46 +++++++++++++++++++--------------------
>>   qga/commands-win32.c      | 22 +++++++++----------
>>   5 files changed, 41 insertions(+), 43 deletions(-)
>>
>> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>> index b720dd4379..51683f4dc2 100644
>> --- a/qga/qapi-schema.json
>> +++ b/qga/qapi-schema.json
>> @@ -6,8 +6,9 @@
>     ##
>     # = General note concerning the use of guest agent interfaces
>>   #
>>   # "unsupported" is a higher-level error than the errors that
>>   # individual commands might document.  The caller should always be
>> -# prepared to receive QERR_UNSUPPORTED, even if the given command
>> -# doesn't specify it, or doesn't document any failure mode at all.
>> +# prepared to receive the "this feature or command is not currently supported"
>> +# message, even if the given command doesn't specify it, or doesn't document
>> +# any failure mode at all.
>>   ##
>>   
>>   ##
> 
> The comment is problematic before the patch.  It's a doc comment,
> i.e. it goes into the "QEMU Guest Agent Protocol Reference" manual,
> where QERR_UNSUPPORTED is meaningless.  Back when the comment was added
> (commit 9481ecd737b "qga schema: document generic QERR_UNSUPPORTED"), it
> was still internal documentation, where QERR_UNSUPPORTED made sense.  It
> became external documentation four years later (commit 56e8bdd46a8
> "build-sys: add qapi doc generation targets")
> 
> I'm not sure how useful the comment is.
> 
> I guess we could instead simply point out that clients should always be
> prepared for errors, even when the command doesn't document any, simply
> because commands need not exist in all versions or builds of qemu-ga.
> 
>> diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
>> index 840831cc6a..7606f4525d 100644
>> --- a/include/qapi/qmp/qerror.h
>> +++ b/include/qapi/qmp/qerror.h
>> @@ -17,7 +17,4 @@
>>    * add new ones!
>>    */
>>   
>> -#define QERR_UNSUPPORTED \
>> -    "this feature or command is not currently supported"
>> -
>>   #endif /* QERROR_H */
>> diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
>> index 17bddda1cf..11536f148f 100644
>> --- a/qga/commands-bsd.c
>> +++ b/qga/commands-bsd.c
>> @@ -152,25 +152,25 @@ int qmp_guest_fsfreeze_do_thaw(Error **errp)
>>   
>>   GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
>>   
>>   GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
>>   
>>   GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
>>   
>>   GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
> 
> These are all commands that are not supported by this build of qemu-ga.
> We could use the opportunity to improve the error message: scratch
> "feature or ".  Or maybe change the message to "this command is not
> supported in this version of qemu-ga".
> 
> More of the same below, marked [*].
> 
> Taking a step back...  Do we really need to make this a failure of its
> own?  Why not fail exactly as if the command didn't exist?  Why would a
> client ever care for the difference between "command doesn't exist in
> this build of qemu-ga (but it does in other builds of this version of
> qemu-ga)" and "command doesn't exist in this build of qemu-ga (and it
> won't in any build of this version of qemu-ga)"?
> 
> If clients don't care, we could instead unregister these commands,
> i.e. undo qmp_register_command().  The command will then fail exactly
> like any other unknown command.  We still need to provide the functions
> to make the linker happy (unless we play with weak symbols), but they
> can simply abort().
> 
> Michael and/or Konstantin, do you have comments as maintainers?  A
> preference even?
> 
> Hmm, there's yet another mechanism to disable commands:
> qmp_disable_command() & friends.  Looks like its purpose is letting
> guest system administrators disable commands, and also to disable a
> bunch of commands in "frozen state", whatever that is.  Alright, I
> didn't see that, lalala.
> 
>>   #endif /* CONFIG_FSFREEZE */
>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> index 6169bbf7a0..f510add366 100644
>> --- a/qga/commands-posix.c
>> +++ b/qga/commands-posix.c
>> @@ -165,7 +165,7 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
>>       }
>>   
>>       if (!hwclock_available) {
>> -        error_setg(errp, QERR_UNSUPPORTED);
>> +        error_setg(errp, "this feature or command is not currently supported");
>>           return;
>>       }
>>   
> 
> !hwclock_available means /sbin/hwclock grants execute permission for the
> process's real UID and GID.  I'm not sure why we bother to check that.
> Why not let execl() fail, and report that error?  Oh, we don't:
> 
>             /* Use '/sbin/hwclock -w' to set RTC from the system time,
>              * or '/sbin/hwclock -s' to set the system time from RTC. */
>             execl(hwclock_path, "hwclock", has_time ? "-w" : "-s", NULL);
>             _exit(EXIT_FAILURE);
> 
> This is wrong.  We should error_setg_errno(errp, errno, ...); return
> instead.  Not your patch's problem.
> 
> Until we do that: [*]
> 
>> @@ -1540,7 +1540,7 @@ GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
>>   
>>   GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
> 
> Command not supported by this build of qemu-qa: [*].
> 
>>   
>> @@ -2235,7 +2235,7 @@ void qmp_guest_set_user_password(const char *username,
>>                                    bool crypted,
>>                                    Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>   }
>>   #endif /* __linux__ || __FreeBSD__ */
>>   
>> @@ -2751,47 +2751,47 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
>>   
>>   void qmp_guest_suspend_disk(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>   }
>>   
>>   void qmp_guest_suspend_ram(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>   }
>>   
>>   void qmp_guest_suspend_hybrid(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>   }
>>   
>>   GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
>>   
>>   int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return -1;
>>   }
>>   
>>   GuestMemoryBlockList *qmp_guest_get_memory_blocks(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
>>   
>>   GuestMemoryBlockResponseList *
>>   qmp_guest_set_memory_blocks(GuestMemoryBlockList *mem_blks, Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
>>   
>>   GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
>>   
>> @@ -3056,7 +3056,7 @@ error:
>>   
>>   GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
>>   
>> @@ -3066,20 +3066,20 @@ GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
>>   
>>   GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
>>   
>>   GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>   
>>       return 0;
>>   }
>>   
>>   int64_t qmp_guest_fsfreeze_freeze(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>   
>>       return 0;
>>   }
>> @@ -3088,33 +3088,33 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
>>                                          strList *mountpoints,
>>                                          Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>   
>>       return 0;
>>   }
>>   
>>   int64_t qmp_guest_fsfreeze_thaw(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>   
>>       return 0;
>>   }
>>   
>>   GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
>>   
>>   GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
>>   
>>   GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
>>   
>> @@ -3124,7 +3124,7 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
>>   GuestFilesystemTrimResponse *
>>   qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
>>   #endif
>> @@ -3243,7 +3243,7 @@ GuestUserList *qmp_guest_get_users(Error **errp)
>>   
>>   GuestUserList *qmp_guest_get_users(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
>>   
>> @@ -3386,7 +3386,7 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
>>   
>>   GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>   
>>       return NULL;
>>   }
> 
> Commands not supported by this build of qemu-qa: [*].
> 
>> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>> index aa8c9770d4..5c9f8e0923 100644
>> --- a/qga/commands-win32.c
>> +++ b/qga/commands-win32.c
>> @@ -1213,7 +1213,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
>>   GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)
>>   {
>>       if (!vss_initialized()) {
>> -        error_setg(errp, QERR_UNSUPPORTED);
>> +        error_setg(errp, "this feature or command is not currently supported");
>>           return 0;
>>       }
>>   
>> @@ -1241,7 +1241,7 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
>>       Error *local_err = NULL;
>>   
>>       if (!vss_initialized()) {
>> -        error_setg(errp, QERR_UNSUPPORTED);
>> +        error_setg(errp, "this feature or command is not currently supported");
>>           return 0;
>>       }
>>   
>> @@ -1276,7 +1276,7 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
>>       int i;
>>   
>>       if (!vss_initialized()) {
>> -        error_setg(errp, QERR_UNSUPPORTED);
>> +        error_setg(errp, "this feature or command is not currently supported");
>>           return 0;
>>       }
>>   
> 
> !vss_initialized() means qga-vss.dll failed to load and initialize.
> 
> Another [*].
> 
>> @@ -1509,7 +1509,7 @@ out:
>>   
>>   void qmp_guest_suspend_hybrid(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>   }
>>   
>>   static IP_ADAPTER_ADDRESSES *guest_get_adapters_addresses(Error **errp)
>> @@ -1877,7 +1877,7 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
>>   
>>   int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return -1;
>>   }
>>   
> 
> Commands not supported by this build of qemu-qa: [*].
> 
>> @@ -1938,7 +1938,7 @@ void qmp_guest_set_user_password(const char *username,
>>       GError *gerr = NULL;
>>   
>>       if (crypted) {
>> -        error_setg(errp, QERR_UNSUPPORTED);
>> +        error_setg(errp, "this feature or command is not currently supported");
>>           return;
>>       }
> 
> Command does not support "crypted": true in this build of qemu-ga.  The
> error message is crap.  Better would be some variation of "this machine
> supports only clear-text passwords".
> 
>>   
>> @@ -1983,20 +1983,20 @@ done:
>>   
>>   GuestMemoryBlockList *qmp_guest_get_memory_blocks(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
>>   
>>   GuestMemoryBlockResponseList *
>>   qmp_guest_set_memory_blocks(GuestMemoryBlockList *mem_blks, Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
>>   
>>   GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
>>   
>> @@ -2522,12 +2522,12 @@ char *qga_get_host_name(Error **errp)
>>   
>>   GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
>>   
>>   GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
>>   {
>> -    error_setg(errp, QERR_UNSUPPORTED);
>> +    error_setg(errp, "this feature or command is not currently supported");
>>       return NULL;
>>   }
> 
> Commands not supported by this build of qemu-qa: [*].
> 
> Summary of my review:
> 
> * You're unsure about your change to the "General note concerning the
>    use of guest agent interfaces".  I suggested a way to rewrite it.
> 
> * Error messages could use improvement.  Since your patch doesn't change
>    any, feel free to leave that for another day.
> 
> * How we do compiled-out commands could use improvement.  Feel even more
>    free to leave for another day.  I'd like to hear the maintainers'
>    opinion, though.
> 
> 


