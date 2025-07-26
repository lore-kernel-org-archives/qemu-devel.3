Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0728CC83F17
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Jul 2025 12:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufeKW-0006sC-2e; Sat, 26 Jul 2025 08:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ufeKS-0006nz-WB; Sat, 26 Jul 2025 08:48:45 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ufeKP-0004e5-IG; Sat, 26 Jul 2025 08:48:44 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56QCmCZ9082853
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 26 Jul 2025 21:48:12 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=BCKxxOnds2qLLv9YuTT9XNTWzMy0II+wkBdqyEWwCj4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1753534093; v=1;
 b=Y87Grg4Yuwcb6g7CYLKTyrGAImvtYsvz40KIS7FClZ20o1lwUC9TrFnBbRRwOuoe
 XSxN8l4gDSvZeot/9f5md7gZPjojt5H12IPlReh2M6D4nWzGCEdY4hCiaCNvWSCW
 VLa9rEpf04pRTV/gZM15Jrc3+oVfA5P8qVe1f0lG/A0c8qIBymRLUmaZxZpV0rLi
 yTlkVkjQmOFpSw5AcJIV2/6hpQdeyK1Ga2OKik+d21FvHj3MKMm4Vh7ZiPRlhkaw
 QqUCbm6a8vo3U5+tlS1aY57KUBUEKUHBJQ1LmjJbhYfAWu9Xdosv+G/GE77cSzqS
 droOTaolAz6tuDiX02HmNg==
Message-ID: <848e0e7e-2ad5-4d94-99eb-8314540ea0de@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 26 Jul 2025 21:48:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 23/24] migration: Add error-parameterized function
 variants in VMSD struct
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-23-d52704443975@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250725-propagate_tpm_error-v7-23-d52704443975@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/07/25 21:19, Arun Menon wrote:
> - We need to have good error reporting in the callbacks in
>    VMStateDescription struct. Specifically pre_save, post_save,
>    pre_load and post_load callbacks.
> - It is not possible to change these functions everywhere in one
>    patch, therefore, we introduce a duplicate set of callbacks
>    with Error object passed to them.
> - So, in this commit, we implement 'errp' variants of these callbacks,
>    introducing an explicit Error object parameter.
> - This is a functional step towards transitioning the entire codebase
>    to the new error-parameterized functions.
> - Deliberately called in mutual exclusion from their counterparts,
>    to prevent conflicts during the transition.
> - New impls should preferentally use 'errp' variants of
>    these methods, and existing impls incrementally converted.
>    The variants without 'errp' are intended to be removed
>    once all usage is converted.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   include/migration/vmstate.h | 11 ++++++++
>   migration/vmstate.c         | 62 +++++++++++++++++++++++++++++++++++++++------
>   2 files changed, 65 insertions(+), 8 deletions(-)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 056781b1c21e737583f081594d9f88b32adfd674..53fa72c1bbde399be02c88fc8745fdbb79bfd7c8 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -200,15 +200,26 @@ struct VMStateDescription {
>        * exclusive. For this reason, also early_setup VMSDs are migrated in a
>        * QEMU_VM_SECTION_FULL section, while save_setup() data is migrated in
>        * a QEMU_VM_SECTION_START section.
> +     *
> +     * There are duplicate impls of the post/pre save/load hooks.
> +     * New impls should preferentally use 'errp' variants of these
> +     * methods and existing impls incrementally converted.
> +     * The variants without 'errp' are intended to be removed
> +     * once all usage is converted.
>        */
> +
>       bool early_setup;
>       int version_id;
>       int minimum_version_id;
>       MigrationPriority priority;
>       int (*pre_load)(void *opaque);
> +    int (*pre_load_errp)(void *opaque, Error **errp);
>       int (*post_load)(void *opaque, int version_id);
> +    int (*post_load_errp)(void *opaque, int version_id, Error **errp);
>       int (*pre_save)(void *opaque);
> +    int (*pre_save_errp)(void *opaque, Error **errp);
>       int (*post_save)(void *opaque);
> +    int (*post_save_errp)(void *opaque, Error **errp);
>       bool (*needed)(void *opaque);
>       bool (*dev_unplug_pending)(void *opaque);
>   
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index bb5e9bf38d6ee7619ceb3e9da29209581c3c12eb..e427ef49b2b1991b0a3cdb14d641c197e00014b0 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -152,7 +152,16 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>           trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
>           return -EINVAL;
>       }
> -    if (vmsd->pre_load) {
> +    if (vmsd->pre_load_errp) {
> +        ret = vmsd->pre_load_errp(opaque, errp);
> +        if (ret) {
> +            error_prepend(errp, "VM pre load failed for: '%s', "
> +                          "version_id: '%d', minimum version_id: '%d', "
> +                          "ret: %d: ", vmsd->name, vmsd->version_id,
> +                          vmsd->minimum_version_id, ret);
> +            return ret;
> +        }
> +    } else if (vmsd->pre_load) {
>           ret = vmsd->pre_load(opaque);
>           if (ret) {
>               error_setg(errp, "VM pre load failed for: '%s', "
> @@ -236,7 +245,14 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>           qemu_file_set_error(f, ret);
>           return ret;
>       }
> -    if (vmsd->post_load) {
> +    if (vmsd->post_load_errp) {
> +        ret = vmsd->post_load_errp(opaque, version_id, errp);
> +        if (ret < 0) {
> +            error_prepend(errp, "VM Post load failed for: %s, version_id: %d, "
> +                          "minimum_version: %d, ret: %d: ", vmsd->name,
> +                          vmsd->version_id, vmsd->minimum_version_id, ret);
> +        }
> +    } else if (vmsd->post_load) {
>           ret = vmsd->post_load(opaque, version_id);
>           if (ret < 0) {
>               error_setg(errp,
> @@ -412,11 +428,19 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                            void *opaque, JSONWriter *vmdesc, int version_id, Error **errp)
>   {
>       int ret = 0;
> +    Error *local_err = NULL;
>       const VMStateField *field = vmsd->fields;
>   
>       trace_vmstate_save_state_top(vmsd->name);
>   
> -    if (vmsd->pre_save) {
> +    if (vmsd->pre_save_errp) {
> +        ret = vmsd->pre_save_errp(opaque, errp);
> +        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
> +        if (ret) {
> +            error_prepend(errp, "pre-save failed: %s: ", vmsd->name);
> +            return ret;
> +        }
> +    } else if (vmsd->pre_save) {
>           ret = vmsd->pre_save(opaque);
>           trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
>           if (ret) {
> @@ -524,10 +548,22 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                   }
>   
>                   if (ret) {
> -                    error_setg(errp, "Save of field %s/%s failed",
> -                                vmsd->name, field->name);
> -                    if (vmsd->post_save) {
> -                        vmsd->post_save(opaque);
> +                    if (*errp == NULL) {

include/qapi/error.h says:
 >  * - You may pass NULL to not receive the error, &error_abort to abort
 >  *   on error, &error_fatal to exit(1) on error, or a pointer to a
 >  *   variable containing NULL to receive the error.

 >  * - The function may pass @errp to functions it calls to pass on
 >  *   their errors to its caller.  If it dereferences @errp to check
 >  *   for errors, it must use ERRP_GUARD().

I also think this change is irrelevant with the addition of the new 
'errp' variants; it fixes an assertion failure when 
vmstate_save_state_v() failed and set errp. It is not a new problem 
caused by the 'errp' variants.

If that's true, this change should have its own explanation in the patch 
message, and also be split into another patch as "a commit message that 
mentions 'Also, ...' is often a good candidate for splitting into 
multiple patches." (docs/devel/submitting-a-patch.rst)

> +                        error_setg(errp, "Save of field %s/%s failed",
> +                                   vmsd->name, field->name);
> +                    }
> +                    if (vmsd->post_save_errp) {
> +                        int ps_ret = vmsd->post_save_errp(opaque, &local_err);
> +                        if (ps_ret < 0) {

The error checks else this and next ps_ret checks only care if it's zero 
or not, but this checks for the sign, leading to inconsistency.

> +                            error_free_or_abort(errp);
> +                            error_propagate(errp, local_err);
> +                            ret = ps_ret;
> +                        }
> +                    } else if (vmsd->post_save) {
> +                        int ps_ret = vmsd->post_save(opaque);
> +                        if (ps_ret < 0) {
> +                            ret = ps_ret;
> +                        }
>                       }
>                       return ret;
>                   }
> @@ -554,7 +590,17 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>   
>       ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
>   
> -    if (vmsd->post_save) {
> +    if (vmsd->post_save_errp) {
> +        int ps_ret = vmsd->post_save_errp(opaque, &local_err);
> +        if (!ret && ps_ret) {
> +            ret = ps_ret;
> +            error_propagate(errp, local_err);
> +        } else if (ret && ps_ret) {
> +            error_free_or_abort(errp);
> +            error_propagate(errp, local_err);
> +            ret = ps_ret;
> +        }

Simpler:

if (ps_ret) {
     if (ret) {
       error_free_or_abort(errp);
     }
     ret = ps_ret;
     error_propagate(errp, local_err);
}

> +    } else if (vmsd->post_save) {
>           int ps_ret = vmsd->post_save(opaque);
>           if (!ret && ps_ret) {
>               ret = ps_ret;

When there is a preceding error, this code still returns it and 
dismisses the post_save() error although the other part of this function 
is changed to propagate the error of post-save unconditionally. Please 
keep them consistent.

> 


