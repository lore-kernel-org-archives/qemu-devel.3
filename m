Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD93CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOdp-0003Ve-6c; Mon, 27 Oct 2025 10:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDOdX-0003TR-KZ
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:56:01 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDOdP-0001h2-Jj
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:55:54 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0E562804CC;
 Mon, 27 Oct 2025 17:55:37 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c5c::1:11] (unknown
 [2a02:6bf:8080:c5c::1:11])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ZtdR2F2b54Y0-9xpkfmx9; Mon, 27 Oct 2025 17:55:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761576936;
 bh=ns+orQ3EiKcFwmGBHZpuJPsIgpth6vYkC/weZsUMItQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=B9He38kuEIKKf34hUa0iOqbs+PwfizEtt0hjNZCTyZhQZhRDBnlUYhFbIlacJkQF4
 GC3obVo53M++/5gpCuFAapFW/rHpkowOn0U+mvK6hIXyxAwRuguS3GJZoOtxe5Zq6a
 WDKsoeNnx2NEgoxNpao9ypr1pc3F5oHOgmu6FJKY=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <fc19579b-0324-4641-95ed-ad3fa1dbbc11@yandex-team.ru>
Date: Mon, 27 Oct 2025 17:55:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] migration/vmstate: stop reporting error number for
 new _errp APIs
To: Stefan Berger <stefanb@linux.ibm.com>, peterx@redhat.com
Cc: stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 armbru@redhat.com, berrange@redhat.com
References: <20251025202649.1122420-1-vsementsov@yandex-team.ru>
 <20251025202649.1122420-4-vsementsov@yandex-team.ru>
 <d2e887cb-5752-4ccb-a0ab-d66a655e6585@linux.ibm.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <d2e887cb-5752-4ccb-a0ab-d66a655e6585@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 27.10.25 17:38, Stefan Berger wrote:
> 
> 
> On 10/25/25 4:26 PM, Vladimir Sementsov-Ogievskiy wrote:
>> First, the handlers should put all needed information into errp,
>> we should not append error number here.
>>
>> Second, the only realization of new _errp API is
>> tpm_emulator_post_load(), which on some failure paths returns
>> -errno, but on the others simply -1. So printing this additional
>> number may be misleading. tpm_emulator.c needs a lot more work
>> to report good error message on all error paths.
> 
> You mean in all paths or just the .post_load_errp path? In the .post_load_errp cases -EIO is currently always returned if called functions failed and return a -1. So their -1 does not propagate.


Oops, excuse me, I was wrong.

Now I see that tpm_emulator_post_load return either 0 or -EIO on all paths.


> 
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   migration/vmstate.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>> index fd066f910e..677e56c84a 100644
>> --- a/migration/vmstate.c
>> +++ b/migration/vmstate.c
>> @@ -157,9 +157,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>>           ret = vmsd->pre_load_errp(opaque, errp);
>>           if (ret < 0) {
>>               error_prepend(errp, "pre load hook failed for: '%s', "
>> -                          "version_id: %d, minimum version_id: %d, "
>> -                          "ret: %d: ", vmsd->name, vmsd->version_id,
>> -                          vmsd->minimum_version_id, ret);
>> +                          "version_id: %d, minimum version_id: %d: ",
>> +                          vmsd->name, vmsd->version_id,
>> +                          vmsd->minimum_version_id);
>>               return ret;
>>           }
>>       } else if (vmsd->pre_load) {
>> @@ -259,8 +259,8 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>>           ret = vmsd->post_load_errp(opaque, version_id, errp);
>>           if (ret < 0) {
>>               error_prepend(errp, "post load hook failed for: %s, version_id: "
>> -                          "%d, minimum_version: %d, ret: %d: ", vmsd->name,
>> -                          vmsd->version_id, vmsd->minimum_version_id, ret);
>> +                          "%d, minimum_version: %d: ", vmsd->name,
>> +                          vmsd->version_id, vmsd->minimum_version_id);
>>           }
>>       } else if (vmsd->post_load) {
>>           ret = vmsd->post_load(opaque, version_id);
>> @@ -441,8 +441,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>>           ret = vmsd->pre_save_errp(opaque, errp);
>>           trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
>>           if (ret < 0) {
>> -            error_prepend(errp, "pre-save for %s failed, ret: %d: ",
>> -                          vmsd->name, ret);
>> +            error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
>>               return ret;
>>           }
>>       } else if (vmsd->pre_save) {
> 


-- 
Best regards,
Vladimir

