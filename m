Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E50CD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 17:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJbI5-00035C-D0; Thu, 13 Nov 2025 12:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vJbI3-00034t-7G
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 12:39:23 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vJbI0-0000NB-VY
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 12:39:22 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 07D5088EFC;
 Thu, 13 Nov 2025 20:39:15 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:833::1:4] (unknown [2a02:6bf:8080:833::1:4])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EdUh1O0FACg0-kblKpRfT; Thu, 13 Nov 2025 20:39:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1763055554;
 bh=ldF9vFq23XTFRBcQvyBlYKgGF7IFnCsQnyhqAFbC058=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=fwbGqzV0YAw459E1hvsCET1vQQOuILuOQ9BWI4YJno94pryoNL/kf2HSC/EXOh2jW
 pQ8f+/O0oePSTdPtQSLLKJGLrMhF4F4UH7z6APflIi4TKqO9GalpEr/0Fto2y4zTfF
 urHPHH56bt3l5+AXmbKWJnUqowia1Q1E8DizrX/U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <69be9780-db0d-46a5-9686-84fd961df173@yandex-team.ru>
Date: Thu, 13 Nov 2025 20:39:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/unit: add unit test for qemu_hexdump()
To: Eric Blake <eblake@redhat.com>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, philmd@linaro.org
References: <20251113064935.342018-1-vsementsov@yandex-team.ru>
 <tokibkrjha4hqa6pwgviht3nwhryw4gnmobklabl2myb2wfk3x@bm6kam2fydl4>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <tokibkrjha4hqa6pwgviht3nwhryw4gnmobklabl2myb2wfk3x@bm6kam2fydl4>
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

On 13.11.25 16:56, Eric Blake wrote:
> On Thu, Nov 13, 2025 at 09:49:35AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Test, that fix in previous commit make sense.
> 
> "previous commit" is ambiguous, when this patch is not part of a
> larger series. Maybe use the term "recent commit" and call out its
> title and/or commit hash?

Good caught! So we need to rewrite first line into

Test for the  fix in recent commit
  20aa05ed "util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic"


> 
>> +++ b/tests/unit/test-cutils.c
>> @@ -3626,6 +3626,44 @@ static void test_si_prefix(void)
>>       g_assert_cmpstr(si_prefix(18), ==, "E");
>>   }
>>   
>> +static void test_qemu_hexdump_alignment(void)
>> +{
>> +    /*
>> +     * Test that ASCII part is properly aligned for incomplete lines.
>> +     * This test catches the bug that was fixed in previous commit
>> +     * "util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic".
> 
> Ah - that's the line I was expecting in the commit message; and I
> found commit 20aa05ed from there.
> 
> 


-- 
Best regards,
Vladimir

