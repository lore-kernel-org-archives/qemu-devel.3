Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16C4CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 20:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDTq0-0006mV-W2; Mon, 27 Oct 2025 16:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDTpy-0006mA-Hs
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 16:29:06 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDTpp-0006Mn-CR
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 16:29:01 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9874681227;
 Mon, 27 Oct 2025 23:28:44 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c5c::1:11] (unknown
 [2a02:6bf:8080:c5c::1:11])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id hSjsFo1FkuQ0-cFy4Qvhy; Mon, 27 Oct 2025 23:28:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761596924;
 bh=1kgusamLg5YaFH/nUraO49uCRyF7S6mNldDPi6FjOs8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ZIe74Jg1w/QgB+oBaTyn6wCspBRLsBiE63pH3D1rS3WUu6dAyxlHwtiTzf+zshr5u
 EVf9UB5kKXs8v1tZFKGC7NP0igzjQFAIVQXyq6aW5H1cd9O/bCQN64gsV5y/iuIQ87
 EEknX5KLv2gX+2h1h004a1/G0gidjmvJBEUBagao=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f2aa1684-8a15-483a-a668-9c5c9c2193bc@yandex-team.ru>
Date: Mon, 27 Oct 2025 23:28:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] migration/vmstate: stop reporting error number for
 new _errp APIs
To: Markus Armbruster <armbru@redhat.com>
Cc: peterx@redhat.com, stefanb@linux.vnet.ibm.com, farosas@suse.de,
 qemu-devel@nongnu.org, berrange@redhat.com
References: <20251025202649.1122420-1-vsementsov@yandex-team.ru>
 <20251025202649.1122420-4-vsementsov@yandex-team.ru>
 <87tszkod89.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87tszkod89.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 27.10.25 13:23, Markus Armbruster wrote:
> What do you mean by "new _errp APIs"?  Is it the pre_load_errp(),
> post_load_errp(), pre_save_errp() callbacks?

Yes

> 
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> First, the handlers should put all needed information into errp,
>> we should not append error number here.
>>
>> Second, the only realization of new _errp API is
>> tpm_emulator_post_load(), which on some failure paths returns
>> -errno, but on the others simply -1. So printing this additional
>> number may be misleading. tpm_emulator.c needs a lot more work
>> to report good error message on all error paths.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   migration/vmstate.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>> index fd066f910e..677e56c84a 100644
>> --- a/migration/vmstate.c
>> +++ b/migration/vmstate.c
>> @@ -157,9 +157,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>>           ret = vmsd->pre_load_errp(opaque, errp);
>>           if (ret < 0) {
>>               error_prepend(errp, "pre load hook failed for: '%s', "
>> -                          "version_id: %d, minimum version_id: %d, "
>> -                          "ret: %d: ", vmsd->name, vmsd->version_id,
>> -                          vmsd->minimum_version_id, ret);
>> +                          "version_id: %d, minimum version_id: %d: ",
>> +                          vmsd->name, vmsd->version_id,
>> +                          vmsd->minimum_version_id);
>>               return ret;
>>           }
>>       } else if (vmsd->pre_load) {
>> @@ -259,8 +259,8 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>>           ret = vmsd->post_load_errp(opaque, version_id, errp);
>>           if (ret < 0) {
>>               error_prepend(errp, "post load hook failed for: %s, version_id: "
>> -                          "%d, minimum_version: %d, ret: %d: ", vmsd->name,
>> -                          vmsd->version_id, vmsd->minimum_version_id, ret);
>> +                          "%d, minimum_version: %d: ", vmsd->name,
>> +                          vmsd->version_id, vmsd->minimum_version_id);
>>           }
>>       } else if (vmsd->post_load) {
>>           ret = vmsd->post_load(opaque, version_id);
>> @@ -441,8 +441,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>>           ret = vmsd->pre_save_errp(opaque, errp);
>>           trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
>>           if (ret < 0) {
>> -            error_prepend(errp, "pre-save for %s failed, ret: %d: ",
>> -                          vmsd->name, ret);
>> +            error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
>>               return ret;
>>           }
>>       } else if (vmsd->pre_save) {
> 
> All good.  However, there are more error messages with numeric error
> codes in this file.  I figure you're leaving them for another day.
> That's okay, but I'd suggest to mention this in your commit message.
> 

Yes.. Will do, if we continue going this way.

-- 
Best regards,
Vladimir

