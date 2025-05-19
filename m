Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D99C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 18:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH5Bw-0008IP-2F; Mon, 19 May 2025 14:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1uH5Bf-00081w-On
 for qemu-devel@nongnu.org; Mon, 19 May 2025 14:26:12 -0400
Received: from bm.lauterbach.com ([62.154.241.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1uH5Ba-0001Bc-Oc
 for qemu-devel@nongnu.org; Mon, 19 May 2025 14:26:06 -0400
Received: from [10.2.13.100] (unknown [10.2.13.100])
 (Authenticated sender: mario.fleischmann@lauterbach.com)
 by bm.lauterbach.com (Postfix) with ESMTPSA id 0AD041CC092D1;
 Mon, 19 May 2025 20:26:01 +0200 (CEST)
Message-ID: <70afe6d2-847b-486e-9d40-3ddbfc4aab13@lauterbach.com>
Date: Mon, 19 May 2025 20:26:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/20] gdbstub: Expose GDBRegisterState
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
 <20250430052741.21145-13-mario.fleischmann@lauterbach.com>
 <swi2up.1p55n77aa7new@linaro.org>
Content-Language: en-US
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
In-Reply-To: <swi2up.1p55n77aa7new@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1747679161049
Received-SPF: pass client-ip=62.154.241.218;
 envelope-from=mario.fleischmann@lauterbach.com; helo=bm.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 19.05.2025 10:42, Manos Pitsidianakis wrote:
> On Wed, 30 Apr 2025 08:27, Mario Fleischmann <mario.fleischmann@lauterbach.com> wrote:
>> Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
>> ---
>> gdbstub/gdbstub.c      | 7 -------
>> include/exec/gdbstub.h | 8 +++++++-
>> 2 files changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>> index 565f6b3..291ac55 100644
>> --- a/gdbstub/gdbstub.c
>> +++ b/gdbstub/gdbstub.c
>> @@ -48,13 +48,6 @@
>>
>> #include "internals.h"
>>
>> -typedef struct GDBRegisterState {
>> -    int base_reg;
>> -    gdb_get_reg_cb get_reg;
>> -    gdb_set_reg_cb set_reg;
>> -    const GDBFeature *feature;
>> -} GDBRegisterState;
>> -
>> GDBState gdbserver_state;
>>
>> void gdb_init_gdbserver_state(void)
>> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
>> index 0675b0b..c2941e5 100644
>> --- a/include/exec/gdbstub.h
>> +++ b/include/exec/gdbstub.h
>> @@ -16,11 +16,17 @@ typedef struct GDBFeatureBuilder {
>>     int base_reg;
>> } GDBFeatureBuilder;
>>
>> -
> 
> Accidental line deletion here?
> 
> With that fixed,
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Yes, thanks for pointing it out!

