Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622F6C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 18:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6aK3-0005Mp-PO; Mon, 13 May 2024 14:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1s6aK1-0005MU-3d
 for qemu-devel@nongnu.org; Mon, 13 May 2024 14:22:49 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1s6aJy-000119-Em
 for qemu-devel@nongnu.org; Mon, 13 May 2024 14:22:48 -0400
Received: from pps.filterd (m0409408.ppops.net [127.0.0.1])
 by m0409408.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id
 44DHnJhH018155; Mon, 13 May 2024 19:22:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
 content-type:message-id:date:mime-version:subject:to:cc
 :references:from:in-reply-to; s=jan2016.eng; bh=XLkBaHlBLk0/kTHb
 3/YbIwZy+/LBMQqFTyeWYwReTUI=; b=hTX7HBBGilHOEFnUuvzIRCcvcqOhqdRo
 MnrPuzmPEzLH/Q4AfPUwJFssxFesy2QAGjhcIjUTKS7XcLo9dhAtDD67xRG27kXJ
 EaYFFM08gFxohihv9yZ8669r0qTmE3rVhTKqEA4yL2mD2qY8v/qMQWzIJcU9nCUI
 70vjk1dKRWZQjlnk7EmHfQfuTgeP70xYrE9FJa29HkGd7pVR+4O2Hgz6ugpDbGLw
 bL3M1X9SCC1g0nvsaR199gKzZLt09ZRqbJNm2iYfo+FroPSrvGDciLfmjBoVYXvq
 24K4ZkNbyYzli3Rb4NquODOf35bOyA0pgV3I+5IW7jwzF3FDpUPChQ==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18]
 (may be forged))
 by m0409408.ppops.net-00190b01. (PPS) with ESMTPS id 3y2kkkb26u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 May 2024 19:22:40 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id
 44DEwwPf026109; Mon, 13 May 2024 14:22:39 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 3y240xx7rq-1;
 Mon, 13 May 2024 14:22:38 -0400
Received: from [100.64.0.1] (prod-aoa-csiteclt14.bos01.corp.akamai.com
 [172.27.97.51])
 by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 019B93338A;
 Mon, 13 May 2024 18:22:36 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------XQK7VD1l8l1z0ImYdIwhtVIt"
Message-ID: <f855963e-b7dd-4ce8-89dc-dfaa87e896c4@akamai.com>
Date: Mon, 13 May 2024 13:22:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: CPR/liveupdate: test results using prior bug fix
To: peterx@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 "Hunt, Joshua" <johunt@akamai.com>
References: <20240228051315.400759-1-peterx@redhat.com>
 <20240228051315.400759-21-peterx@redhat.com>
Content-Language: en-US
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <20240228051315.400759-21-peterx@redhat.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_12,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405130122
X-Proofpoint-ORIG-GUID: tu2uNo625_XZ1qzL17_zi07G8YRkM5_Z
X-Proofpoint-GUID: tu2uNo625_XZ1qzL17_zi07G8YRkM5_Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_12,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 bulkscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1011
 adultscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405130123
Received-SPF: pass client-ip=67.231.149.131; envelope-from=mgalaxy@akamai.com;
 helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is a multi-part message in MIME format.
--------------XQK7VD1l8l1z0ImYdIwhtVIt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steve,

We found that this specific change in particular ("migration: stop vm 
for cpr") fixes a bug that we've identified in testing back-to-back live 
updates in a lab environment.

More specifically, *without* this change (which is not available in 
8.2.2, but *is* available in 9.0.0) causes the metadata save file to be 
corrupted when doing live updates one after another. Typically we see a 
corrupted save file somewhere in between 20 and 30 live updates and 
while doing a git bisect, we found that this change makes the problem go 
away.

Were you aware? Is there any plan in place to cherry pick this for 
8.2.3, perhaps or a plan to release 8.2.3 at some point?

Here are some examples of how the bug manifests in different locations 
of the QEMU metadata save file:

2024-04-26T13:28:53Z qemu-system-x86_64: Failed to load mtrr_var:base
2024-04-26T13:28:53Z qemu-system-x86_64: Failed to load cpu:env.mtrr_var
2024-04-26T13:28:53Z qemu-system-x86_64: error while loading state for instance 0x1b of device 'cpu'
2024-04-26T13:28:53Z qemu-system-x86_64: load of migration failed: Input/output error

And another:

2024-04-17T16:09:47Z qemu-system-x86_64: check_section_footer: Read section footer failed: -5
2024-04-17T16:09:47Z qemu-system-x86_64: load of migration failed: Invalid argument

And another:

2024-04-30T21:53:29Z qemu-system-x86_64: Unable to read ID string for section 163
2024-04-30T21:53:29Z qemu-system-x86_64: load of migration failed: Invalid argument

And another:

2024-05-01T16:01:44Z qemu-system-x86_64: Unable to read ID string for section 164
2024-05-01T16:01:44Z qemu-system-x86_64: load of migration failed: Invalid argument
  

As you can see, they occur quite randomly, but generally it takes at 
least 20-30+ live updates before the problem occurs.

- Michael

On 2/27/24 23:13, peterx@redhat.com wrote:
> From: Steve Sistare<steven.sistare@oracle.com>
>
> When migration for cpr is initiated, stop the vm and set state
> RUN_STATE_FINISH_MIGRATE before ram is saved.  This eliminates the
> possibility of ram and device state being out of sync, and guarantees
> that a guest in the suspended state remains suspended, because qmp_cont
> rejects a cont command in the RUN_STATE_FINISH_MIGRATE state.
>
> Signed-off-by: Steve Sistare<steven.sistare@oracle.com>
> Reviewed-by: Peter Xu<peterx@redhat.com>
> Link:https://urldefense.com/v3/__https://lore.kernel.org/r/1708622920-68779-11-git-send-email-steven.sistare@oracle.com__;!!GjvTz_vk!QLsFOCX-x2U9bzAo98SdidKlomHrmf_t0UmQKtgudoIcaDVoAJOPm39ZqaNP_nT5I8QqVfSgwhDZmg$  
> Signed-off-by: Peter Xu<peterx@redhat.com>
> ---
>   include/migration/misc.h |  1 +
>   migration/migration.h    |  2 --
>   migration/migration.c    | 51 ++++++++++++++++++++++++----------------
>   3 files changed, 32 insertions(+), 22 deletions(-)
>
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index e4933b815b..5d1aa593ed 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -60,6 +60,7 @@ void migration_object_init(void);
>   void migration_shutdown(void);
>   bool migration_is_idle(void);
>   bool migration_is_active(MigrationState *);
> +bool migrate_mode_is_cpr(MigrationState *);
>   
>   typedef enum MigrationEventType {
>       MIG_EVENT_PRECOPY_SETUP,
> diff --git a/migration/migration.h b/migration/migration.h
> index aef8afbe1f..65c0b61cbd 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -541,6 +541,4 @@ int migration_rp_wait(MigrationState *s);
>    */
>   void migration_rp_kick(MigrationState *s);
>   
> -int migration_stop_vm(RunState state);
> -
>   #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index 37c836b0b0..90a90947fb 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -167,11 +167,19 @@ static gint page_request_addr_cmp(gconstpointer ap, gconstpointer bp)
>       return (a > b) - (a < b);
>   }
>   
> -int migration_stop_vm(RunState state)
> +static int migration_stop_vm(MigrationState *s, RunState state)
>   {
> -    int ret = vm_stop_force_state(state);
> +    int ret;
> +
> +    migration_downtime_start(s);
> +
> +    s->vm_old_state = runstate_get();
> +    global_state_store();
> +
> +    ret = vm_stop_force_state(state);
>   
>       trace_vmstate_downtime_checkpoint("src-vm-stopped");
> +    trace_migration_completion_vm_stop(ret);
>   
>       return ret;
>   }
> @@ -1602,6 +1610,11 @@ bool migration_is_active(MigrationState *s)
>               s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>   }
>   
> +bool migrate_mode_is_cpr(MigrationState *s)
> +{
> +    return s->parameters.mode == MIG_MODE_CPR_REBOOT;
> +}
> +
>   int migrate_init(MigrationState *s, Error **errp)
>   {
>       int ret;
> @@ -2454,10 +2467,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>       bql_lock();
>       trace_postcopy_start_set_run();
>   
> -    migration_downtime_start(ms);
> -
> -    global_state_store();
> -    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
> +    ret = migration_stop_vm(ms, RUN_STATE_FINISH_MIGRATE);
>       if (ret < 0) {
>           goto fail;
>       }
> @@ -2652,15 +2662,12 @@ static int migration_completion_precopy(MigrationState *s,
>       int ret;
>   
>       bql_lock();
> -    migration_downtime_start(s);
> -
> -    s->vm_old_state = runstate_get();
> -    global_state_store();
>   
> -    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
> -    trace_migration_completion_vm_stop(ret);
> -    if (ret < 0) {
> -        goto out_unlock;
> +    if (!migrate_mode_is_cpr(s)) {
> +        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
> +        if (ret < 0) {
> +            goto out_unlock;
> +        }
>       }
>   
>       ret = migration_maybe_pause(s, current_active_state,
> @@ -3500,15 +3507,10 @@ static void *bg_migration_thread(void *opaque)
>       s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
>   
>       trace_migration_thread_setup_complete();
> -    migration_downtime_start(s);
>   
>       bql_lock();
>   
> -    s->vm_old_state = runstate_get();
> -
> -    global_state_store();
> -    /* Forcibly stop VM before saving state of vCPUs and devices */
> -    if (migration_stop_vm(RUN_STATE_PAUSED)) {
> +    if (migration_stop_vm(s, RUN_STATE_PAUSED)) {
>           goto fail;
>       }
>       /*
> @@ -3584,6 +3586,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>       Error *local_err = NULL;
>       uint64_t rate_limit;
>       bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
> +    int ret;
>   
>       /*
>        * If there's a previous error, free it and prepare for another one.
> @@ -3655,6 +3658,14 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>           return;
>       }
>   
> +    if (migrate_mode_is_cpr(s)) {
> +        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
> +        if (ret < 0) {
> +            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
> +            goto fail;
> +        }
> +    }
> +
>       if (migrate_background_snapshot()) {
>           qemu_thread_create(&s->thread, "bg_snapshot",
>                   bg_migration_thread, s, QEMU_THREAD_JOINABLE);
--------------XQK7VD1l8l1z0ImYdIwhtVIt
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Steve,<br>
      <br>
      We found that this specific change in particular ("migration: stop
      vm for cpr") fixes a bug that we've identified in testing
      back-to-back live updates in a lab environment.<br>
      <br>
      More specifically, *without* this change (which is not available
      in 8.2.2, but *is* available in 9.0.0) causes the metadata save
      file to be corrupted when doing live updates one after another.
      Typically we see a corrupted save file somewhere in between 20 and
      30 live updates and while doing a git bisect, we found that this
      change makes the problem go away.<br>
      <br>
      Were you aware? Is there any plan in place to cherry pick this for
      8.2.3, perhaps or a plan to release 8.2.3 at some point?<br>
      <br>
      Here are some examples of how the bug manifests in different
      locations of the QEMU metadata save file:<br>
      <br>
    </p>
    <div class="preformatted panel" style="border-width: 1px;">
      <div class="preformattedContent panelContent">
        <pre>2024-04-26T13:28:53Z qemu-system-x86_64: Failed to load mtrr_var:base
2024-04-26T13:28:53Z qemu-system-x86_64: Failed to load cpu:env.mtrr_var
2024-04-26T13:28:53Z qemu-system-x86_64: error while loading state for instance 0x1b of device 'cpu'
2024-04-26T13:28:53Z qemu-system-x86_64: load of migration failed: Input/output error </pre>
      </div>
    </div>
    <p>And another:<br>
    </p>
    <div class="preformatted panel" style="border-width: 1px;">
      <div class="preformattedContent panelContent">
        <pre>2024-04-17T16:09:47Z qemu-system-x86_64: check_section_footer: Read section footer failed: -5
2024-04-17T16:09:47Z qemu-system-x86_64: load of migration failed: Invalid argument </pre>
      </div>
    </div>
    <p>And another:<br>
    </p>
    <div class="preformatted panel" style="border-width: 1px;">
      <div class="preformattedContent panelContent">
        <pre>2024-04-30T21:53:29Z qemu-system-x86_64: Unable to read ID string for section 163
2024-04-30T21:53:29Z qemu-system-x86_64: load of migration failed: Invalid argument </pre>
      </div>
    </div>
    <p>And another:<br>
    </p>
    <div class="preformatted panel" style="border-width: 1px;">
      <div class="preformattedContent panelContent">
        <pre>2024-05-01T16:01:44Z qemu-system-x86_64: Unable to read ID string for section 164
2024-05-01T16:01:44Z qemu-system-x86_64: load of migration failed: Invalid argument
 </pre>
      </div>
    </div>
    <p>As you can see, they occur quite randomly, but generally it takes
      at least 20-30+ live updates before the problem occurs.<br>
      <br>
      - Michael<br>
    </p>
    <div class="moz-cite-prefix">On 2/27/24 23:13, <a class="moz-txt-link-abbreviated" href="mailto:peterx@redhat.com">peterx@redhat.com</a>
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20240228051315.400759-21-peterx@redhat.com">
      <pre class="moz-quote-pre" wrap="">From: Steve Sistare <a class="moz-txt-link-rfc2396E" href="mailto:steven.sistare@oracle.com">&lt;steven.sistare@oracle.com&gt;</a>

When migration for cpr is initiated, stop the vm and set state
RUN_STATE_FINISH_MIGRATE before ram is saved.  This eliminates the
possibility of ram and device state being out of sync, and guarantees
that a guest in the suspended state remains suspended, because qmp_cont
rejects a cont command in the RUN_STATE_FINISH_MIGRATE state.

Signed-off-by: Steve Sistare <a class="moz-txt-link-rfc2396E" href="mailto:steven.sistare@oracle.com">&lt;steven.sistare@oracle.com&gt;</a>
Reviewed-by: Peter Xu <a class="moz-txt-link-rfc2396E" href="mailto:peterx@redhat.com">&lt;peterx@redhat.com&gt;</a>
Link: <a class="moz-txt-link-freetext" href="https://urldefense.com/v3/__https://lore.kernel.org/r/1708622920-68779-11-git-send-email-steven.sistare@oracle.com__;!!GjvTz_vk!QLsFOCX-x2U9bzAo98SdidKlomHrmf_t0UmQKtgudoIcaDVoAJOPm39ZqaNP_nT5I8QqVfSgwhDZmg$">https://urldefense.com/v3/__https://lore.kernel.org/r/1708622920-68779-11-git-send-email-steven.sistare@oracle.com__;!!GjvTz_vk!QLsFOCX-x2U9bzAo98SdidKlomHrmf_t0UmQKtgudoIcaDVoAJOPm39ZqaNP_nT5I8QqVfSgwhDZmg$</a> 
Signed-off-by: Peter Xu <a class="moz-txt-link-rfc2396E" href="mailto:peterx@redhat.com">&lt;peterx@redhat.com&gt;</a>
---
 include/migration/misc.h |  1 +
 migration/migration.h    |  2 --
 migration/migration.c    | 51 ++++++++++++++++++++++++----------------
 3 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index e4933b815b..5d1aa593ed 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -60,6 +60,7 @@ void migration_object_init(void);
 void migration_shutdown(void);
 bool migration_is_idle(void);
 bool migration_is_active(MigrationState *);
+bool migrate_mode_is_cpr(MigrationState *);
 
 typedef enum MigrationEventType {
     MIG_EVENT_PRECOPY_SETUP,
diff --git a/migration/migration.h b/migration/migration.h
index aef8afbe1f..65c0b61cbd 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -541,6 +541,4 @@ int migration_rp_wait(MigrationState *s);
  */
 void migration_rp_kick(MigrationState *s);
 
-int migration_stop_vm(RunState state);
-
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 37c836b0b0..90a90947fb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -167,11 +167,19 @@ static gint page_request_addr_cmp(gconstpointer ap, gconstpointer bp)
     return (a &gt; b) - (a &lt; b);
 }
 
-int migration_stop_vm(RunState state)
+static int migration_stop_vm(MigrationState *s, RunState state)
 {
-    int ret = vm_stop_force_state(state);
+    int ret;
+
+    migration_downtime_start(s);
+
+    s-&gt;vm_old_state = runstate_get();
+    global_state_store();
+
+    ret = vm_stop_force_state(state);
 
     trace_vmstate_downtime_checkpoint("src-vm-stopped");
+    trace_migration_completion_vm_stop(ret);
 
     return ret;
 }
@@ -1602,6 +1610,11 @@ bool migration_is_active(MigrationState *s)
             s-&gt;state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
 
+bool migrate_mode_is_cpr(MigrationState *s)
+{
+    return s-&gt;parameters.mode == MIG_MODE_CPR_REBOOT;
+}
+
 int migrate_init(MigrationState *s, Error **errp)
 {
     int ret;
@@ -2454,10 +2467,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     bql_lock();
     trace_postcopy_start_set_run();
 
-    migration_downtime_start(ms);
-
-    global_state_store();
-    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
+    ret = migration_stop_vm(ms, RUN_STATE_FINISH_MIGRATE);
     if (ret &lt; 0) {
         goto fail;
     }
@@ -2652,15 +2662,12 @@ static int migration_completion_precopy(MigrationState *s,
     int ret;
 
     bql_lock();
-    migration_downtime_start(s);
-
-    s-&gt;vm_old_state = runstate_get();
-    global_state_store();
 
-    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
-    trace_migration_completion_vm_stop(ret);
-    if (ret &lt; 0) {
-        goto out_unlock;
+    if (!migrate_mode_is_cpr(s)) {
+        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
+        if (ret &lt; 0) {
+            goto out_unlock;
+        }
     }
 
     ret = migration_maybe_pause(s, current_active_state,
@@ -3500,15 +3507,10 @@ static void *bg_migration_thread(void *opaque)
     s-&gt;setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
 
     trace_migration_thread_setup_complete();
-    migration_downtime_start(s);
 
     bql_lock();
 
-    s-&gt;vm_old_state = runstate_get();
-
-    global_state_store();
-    /* Forcibly stop VM before saving state of vCPUs and devices */
-    if (migration_stop_vm(RUN_STATE_PAUSED)) {
+    if (migration_stop_vm(s, RUN_STATE_PAUSED)) {
         goto fail;
     }
     /*
@@ -3584,6 +3586,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     Error *local_err = NULL;
     uint64_t rate_limit;
     bool resume = s-&gt;state == MIGRATION_STATUS_POSTCOPY_PAUSED;
+    int ret;
 
     /*
      * If there's a previous error, free it and prepare for another one.
@@ -3655,6 +3658,14 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         return;
     }
 
+    if (migrate_mode_is_cpr(s)) {
+        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
+        if (ret &lt; 0) {
+            error_setg(&amp;local_err, "migration_stop_vm failed, error %d", -ret);
+            goto fail;
+        }
+    }
+
     if (migrate_background_snapshot()) {
         qemu_thread_create(&amp;s-&gt;thread, "bg_snapshot",
                 bg_migration_thread, s, QEMU_THREAD_JOINABLE);
</pre>
    </blockquote>
  </body>
</html>

--------------XQK7VD1l8l1z0ImYdIwhtVIt--

