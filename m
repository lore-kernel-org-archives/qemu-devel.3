Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A769EFCE20
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 17:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqAp-0006fK-UF; Wed, 04 Mar 2026 12:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxqAn-0006Li-F7
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:38:13 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxqAk-00058L-GP
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:38:13 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id AD9B3C01D0;
 Wed, 04 Mar 2026 20:38:05 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:921::1:1b] (unknown
 [2a02:6bf:8080:921::1:1b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4cs2c60AvOs0-PDJfs0XZ; Wed, 04 Mar 2026 20:38:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772645885;
 bh=LBDin7RkGLtF/pmrNQGsLtrNzXgQAOz9a/M93JH2U/s=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=gD5q+5NCEYRoiS1pI3essX7B2EqWmBx1EdoZBey/NXd7akbtWKMKc/S/RQn30ZM37
 PMDhY16W792wrclXStV+NsVMCZdqp7BSzExhhmhJrxh/2IamcRg1fooSltFe3yNIAq
 gL/12+IEeMExrT49kUC9GY6EzB/Usk/L5OL1G+yo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6ca052d7-c7b1-4ab0-9bb4-39a78874cf96@yandex-team.ru>
Date: Wed, 4 Mar 2026 20:38:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/16] migration/vmstate-types: move to new migration
 APIs
To: Peter Xu <peterx@redhat.com>
Cc: farosas@suse.de, "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-17-vsementsov@yandex-team.ru>
 <aacS1YUD0xesMufw@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aacS1YUD0xesMufw@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 03.03.26 19:56, Peter Xu wrote:
> On Sat, Feb 21, 2026 at 12:02:14AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Likewise.. one trivial thing to mention below..
> 
> [...]
> 
>>   /* 32 bit int. See that the received value is the same than the one
>>      in the field */
>>   
>> -static int get_int32_equal(QEMUFile *f, void *pv, size_t size,
>> -                           const VMStateField *field)
>> +static bool load_int32_equal(QEMUFile *f, void *pv, size_t size,
>> +                             const VMStateField *field, Error **errp)
>>   {
>> +    ERRP_GUARD();
>>       int32_t *v = pv;
>>       int32_t v2;
>>       qemu_get_sbe32s(f, &v2);
>>   
>>       if (*v == v2) {
>> -        return 0;
>> +        return true;
>>       }
>> -    error_report("%" PRIx32 " != %" PRIx32, *v, v2);
>> +
>> +    error_setg(errp, "%" PRIx32 " != %" PRIx32, *v, v2);
>>       if (field->err_hint) {
>> -        error_printf("%s\n", field->err_hint);
>> +        error_append_hint(errp, "%s\n", field->err_hint);
> 
> According to doc for error_append_hint():
> 
> /*
>   * Append a printf-style human-readable explanation to an existing error.
>   * If the error is later reported to a human user with
>   * error_report_err() or warn_report_err(), the hints will be shown,
>   * too.  If it's reported via QMP, the hints will be ignored.
>   * Intended use is adding helpful hints on the human user interface,
>   * e.g. a list of valid values.  It's not for clarifying a confusing
>   * error message.
>   * @errp may be NULL, but not &error_fatal or &error_abort.
>   * Trivially the case if you call it only after error_setg() or
>   * error_propagate().
>   * May be called multiple times.  The resulting hint should end with a
>   * newline.
>   */
> 
> It may be ignored if the errp will be finally persisted in MigrationState.
> 
> Not a huge deal because I believe we also do error_report_err()
> somewhere.. but if we want, I think we could use error_append() to make the
> hint available to both.
> 
> This comment applies to all 5 similar occurances in this patch.

Agree, will do. That was intuitive choice "err_hint" -> "append_hint".

Actually, I'm unsure, how much is good to omit hints for QMP interface.
Of course, QMP is for machines. But provided errors are for humans anyway,
machines never parse them (OK, sometimes they do, but that's not a good
practice).

I always wandered, why we try to hide information when reporting errors:
don't report filename, line number.. Don't report these hints. In production
solutions final user will never see any errors from QEMU, so these error
messages are only for engineers. Why we have to grep error messages in
code, instead of get exact filename and line number?

> 
>>       }
>> -    return -EINVAL;
>> +    return false;
>>   }
> 


-- 
Best regards,
Vladimir

