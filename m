Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD17BC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 15:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6uJ4-0002Qh-Mv; Tue, 14 May 2024 11:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1s6uJ1-0002PT-HP
 for qemu-devel@nongnu.org; Tue, 14 May 2024 11:43:07 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1s6uIy-00038V-Uy
 for qemu-devel@nongnu.org; Tue, 14 May 2024 11:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715701382; x=1716306182; i=deller@gmx.de;
 bh=nsmxuaWc/lbkKSRA0caGuW5Wh/aqKnd9BZXxupVlKcI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DmdawgL8rVzV0WlygAHhVuN01aDwp1wpBG6AojJA+SvS43HjCF5CTTU2Nu+YUsE9
 X6GklKdUpdkZyX+QkrY6pLzWw1k2+XUkMkRUw07UksuByeHfN71LSXaoiL519ls6n
 UJRo5VDRb6U46K4+5HyTw9s21PruqDNRcqcI/BOPzQdoapF2nYqab3b6Gd+dqO4tk
 ilgDCjoURXAm7AhfposZueyTsx1YfPDSYjcy4uFlbaeNh/WeNaZYyr08/SPeIYSOK
 5sS45QgS9IwPJVZ/d/6lhMKjV89D4pV3jhO4GZuAhRyzLkDms6AR1Xy7v9urmziSt
 6jGJXSyWGveTLnhGdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.186.200]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8qj-1slCnw3nev-00fycI; Tue, 14
 May 2024 17:43:01 +0200
Message-ID: <69962579-43d1-4611-9606-0753dfc2d24c@gmx.de>
Date: Tue, 14 May 2024 17:43:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/45] target/hppa: Add install_link
To: Helge Deller <deller@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-9-richard.henderson@linaro.org>
 <ZkN3LM1pWLfzVowQ@carbonx1>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ZkN3LM1pWLfzVowQ@carbonx1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yIQwzDcbIF1eaA705Vltvuo1LCD3vLzhvymrPXM5XEq62os31XV
 W3zA8DnyNnksxPSkl7sIAJAcebWouWBerSPdRbcg5cI/UcdCZ825JD6g/yIxPJvCR0QXEfZ
 4SZPcLhsNnEzVmb4dGVAKSKC2HoNWfL/QiUL7ziQovCdu66v6f8LeoowsJJz99Qesk9bNE5
 yuLWQ+s83wZotfWi3kMXg==
UI-OutboundReport: notjunk:1;M01:P0:u9sYs1IIXK4=;8nCAZusYOUXEU/baP/yFdsSuj4I
 68VKdi1aYPipT9t24isdjzi2330Nf29L4X6sn1SDMAMz6jHP7seiUeCuUEzRy+1jyVllq1RsO
 F+7e1/jiTwYUBiMJ2Ry6UZ0hStEaryla5xCdP3gnVsGX8zJ/fX+NUHUi0FeNPrqWb2/E1ZcDj
 QicT8EGY9w7AdS5bavfwK/KHAOfX4pReVNlMAtv9bttFR3RIDZBSa+imrMuQv7SM7IpRjxzNg
 +CHPclhBOJy8ocdp9BI8Igl+/CbfdM0ZyxeJkj+AfyuAMbc5aQnuDAeOTKzYK0CN3C360reIY
 YFJ+q7B8JWnvwJOBIulARQ4doUN2a+i97I5Efmc48bzzlX3FdhBFD8G1Zh4+2BmBTL2QIav8N
 csDRnA59soTQKMC4zWtaNulFGXJWwMBlJ8+oxbWdkyGM/0XQRWjzsUx+t4k+6pT1cQPbVrf4d
 Ox8rX/qC1zAIMjAbR3p3L7wUmVKP8hesv4J7P7ym3BhYvWT4gZnTTmvM8BJL50ryzBsCoS59b
 EP70ZEgQiuHB5f66wlba+mUB1bARNJz8+aB9N7A+WD2caBgJ89Gzg2TZPvpkFgV0qt5UbMW2G
 HF4mQGeUDvvA5lKpyq7pgdXuvzgsWSaq4/wkWbhJIubWsse6/Ypdsunc8gcH+kJMoOr/qa9Em
 UMWCXj9IqNYEeimBudOWRu237kgaCUi0TsJsqb/kIWGNN2E42+FIrXEGjjvYdySbSBp3b2IG9
 LBhYYEDNKMO7TNapEqSOIt+S3HXT1AauRNwb19HdKQSDVPduwPg0MFS/7QU1smmZclUOkFGiO
 Pioc4iKzNK88AwmxHLbSQ580Dt3IAAE1N37KMtI3IZm6E=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/14/24 16:37, Helge Deller wrote:
> * Richard Henderson <richard.henderson@linaro.org>:
>> Add a common routine for writing the return address.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> Reviewed-by: Helge Deller <deller@gmx.de>
>
>> ---
>>   target/hppa/translate.c | 54 +++++++++++++++++++++++-----------------=
-
>>   1 file changed, 31 insertions(+), 23 deletions(-)
>>
>> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
>> index 08d5e2a4bc..f816b337ee 100644
>> --- a/target/hppa/translate.c
>> +++ b/target/hppa/translate.c
>> @@ -634,6 +634,23 @@ static void install_iaq_entries(DisasContext *ctx,=
 uint64_t bi, TCGv_i64 bv,
>>       }
>>   }
>>
>> +static void install_link(DisasContext *ctx, unsigned link, bool with_s=
r0)
>> +{
>> +    tcg_debug_assert(ctx->null_cond.c =3D=3D TCG_COND_NEVER);
>> +    if (link) {
>
> Just wondering:
> Doesn't it makes it easier to write here:
> 	if (!link) {
> 		return;
> 	}
> and then don't indent the few following lines?

I see you change and partly revert it again in patch #17...
so forget this remark for now.

Helge

