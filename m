Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62CDEB28FA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 09:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voILJ-0007x7-QE; Fri, 06 Feb 2026 04:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1voILI-0007wo-Lg
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 04:41:36 -0500
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1voILG-000637-Dx
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 04:41:36 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.24])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4f6py35yNmz5wpH;
 Fri,  6 Feb 2026 09:41:31 +0000 (UTC)
Received: from kaod.org (37.59.142.111) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 6 Feb
 2026 10:41:30 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S005450d0d3d-2b14-486a-8737-938aa377b092,
 C2DCEC2B1261BCA5104DC73024CD17A0EB88A4A8) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <13bb2d85-bc24-4c3c-bdf0-8e4449b75387@kaod.org>
Date: Fri, 6 Feb 2026 10:41:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/10] tests/qtest/ast2700-hace-test: Use ast2700-evb
 alias for AST2700 HACE tests
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
 <20260206053340.3716041-9-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260206053340.3716041-9-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.111]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 335b16e7-bc8c-45bd-a1d9-df6ac95a852e
X-Ovh-Tracer-Id: 13207650334710729534
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE6gtelrx0GIsC3uKa7s9VmXCbJ8stKVdgewvKzCOnf/jtQNl4ZWKye4+oUcrs1mWwaBKq03v3I47LyffYjplFYGBFxS7b1qDRbAdX8wkYnmmZCW6DDsh+3kTOIgrm5EMOl6gc8jq7EGLgTavDxjxbRVz+95YMc1VETxUiSZp7dimkzpR0gGlbAe94yZHiZ9ekEiT/n/grgrC8iOqmhSWrDXmF09/WNk9xzlHoo/XeP34nUcSRYktFXYYcjfBsF1Wtvv7MrM771cfSH9t3Fdqhne61QcjZAlIVeXAMipcIxuh2QmVy7fqG+3o2IM0B3o9XgkYNbr5pWZ3peA61GcCoWUfODN2ifF1ZlCRL17VvcXpqX5vC1WI/gt/rx/P+bIgXy/kO8/UEXL9heEtKB+Ya9c8n0IHQPaK57rf+V1UtbVJVVMc2pvQ4xquchIglF/I6K4EajgNrAQ0xrGZFJU+ftJyiNBdUTnkfniOVbeZZTeXvWg76qxzWNWGANcP31K/c3yxzne/pTlAb3OT5UPPhTFegUj3CwgDdCXbbYDuuhSNYIKICnQN7dQMWU3VjC4mB/EsccPUzUfGw63bBf2lEnbBOXRTcdLwUvobJ7psmtJ+eZdR5m4ixcUv6q0tygd5wPTqY/A3vcRjMSDTGvBq97h3vwSpIYXDykOXm1lr1tIA
DKIM-Signature: a=rsa-sha256; bh=nk92qKw1U+A8j4auddOkqpG9SMOn7avSxYZGdbSuNqA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770370892; v=1;
 b=okTDnfKSOM5iPGEW8ygMTfjqVXgYQELohvbw3i5g+0M7/BuC1C1aWwUhURP1D1Yt8qM2DKBd
 0olEEEYNxB6uS2onbkAfQt9U2Mh/DUaNlaVL73DiY1A2OvIdO9ssUM6lYq+6WWBtGpsIf7ktHC4
 wmZOxv9Sz0pxJRMhfickU0y/2VGQmnDV6o+zp1YMze21mnqeNrcT44LqF7haFT4FuHWFDWTzT7k
 uek1aQt1douzxFIhh+a8vn9A8fndxxGaBfkKGN5qzreFCZO2zYSI0XjpgNNGV2ZqVVzTVtTsLJ2
 IBArRp34Cp7wdqWdHKRsjt2jzgHJ4UC18CEz7hxMLiPrQ==
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/6/26 06:33, Jamin Lin wrote:
> Update AST2700 HACE qtests to use the "ast2700-evb" machine alias
> instead of a specific silicon revision.
> 
> The AST2700 A1 and A2 revisions are compatible for the HACE model, so
> the tests do not depend on a particular EVB revision. Using the
> "ast2700-evb" alias ensures the tests always run the latest
> supported AST2700 silicon revision.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   tests/qtest/ast2700-hace-test.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/qtest/ast2700-hace-test.c b/tests/qtest/ast2700-hace-test.c
> index a400e2962b..508a34dd6c 100644
> --- a/tests/qtest/ast2700-hace-test.c
> +++ b/tests/qtest/ast2700-hace-test.c
> @@ -23,57 +23,57 @@ static const struct AspeedMasks as2700_masks = {
>   /* ast2700 */
>   static void test_md5_ast2700(void)
>   {
> -    aspeed_test_md5("-machine ast2700a1-evb", 0x12070000, 0x400000000);
> +    aspeed_test_md5("-machine ast2700-evb", 0x12070000, 0x400000000);
>   }
>   
>   static void test_sha256_ast2700(void)
>   {
> -    aspeed_test_sha256("-machine ast2700a1-evb", 0x12070000, 0x400000000);
> +    aspeed_test_sha256("-machine ast2700-evb", 0x12070000, 0x400000000);
>   }
>   
>   static void test_sha256_sg_ast2700(void)
>   {
> -    aspeed_test_sha256_sg("-machine ast2700a1-evb", 0x12070000, 0x400000000);
> +    aspeed_test_sha256_sg("-machine ast2700-evb", 0x12070000, 0x400000000);
>   }
>   
>   static void test_sha384_ast2700(void)
>   {
> -    aspeed_test_sha384("-machine ast2700a1-evb", 0x12070000, 0x400000000);
> +    aspeed_test_sha384("-machine ast2700-evb", 0x12070000, 0x400000000);
>   }
>   
>   static void test_sha384_sg_ast2700(void)
>   {
> -    aspeed_test_sha384_sg("-machine ast2700a1-evb", 0x12070000, 0x400000000);
> +    aspeed_test_sha384_sg("-machine ast2700-evb", 0x12070000, 0x400000000);
>   }
>   
>   static void test_sha512_ast2700(void)
>   {
> -    aspeed_test_sha512("-machine ast2700a1-evb", 0x12070000, 0x400000000);
> +    aspeed_test_sha512("-machine ast2700-evb", 0x12070000, 0x400000000);
>   }
>   
>   static void test_sha512_sg_ast2700(void)
>   {
> -    aspeed_test_sha512_sg("-machine ast2700a1-evb", 0x12070000, 0x400000000);
> +    aspeed_test_sha512_sg("-machine ast2700-evb", 0x12070000, 0x400000000);
>   }
>   
>   static void test_sha256_accum_ast2700(void)
>   {
> -    aspeed_test_sha256_accum("-machine ast2700a1-evb", 0x12070000, 0x400000000);
> +    aspeed_test_sha256_accum("-machine ast2700-evb", 0x12070000, 0x400000000);
>   }
>   
>   static void test_sha384_accum_ast2700(void)
>   {
> -    aspeed_test_sha384_accum("-machine ast2700a1-evb", 0x12070000, 0x400000000);
> +    aspeed_test_sha384_accum("-machine ast2700-evb", 0x12070000, 0x400000000);
>   }
>   
>   static void test_sha512_accum_ast2700(void)
>   {
> -    aspeed_test_sha512_accum("-machine ast2700a1-evb", 0x12070000, 0x400000000);
> +    aspeed_test_sha512_accum("-machine ast2700-evb", 0x12070000, 0x400000000);
>   }
>   
>   static void test_addresses_ast2700(void)
>   {
> -    aspeed_test_addresses("-machine ast2700a1-evb", 0x12070000, &as2700_masks);
> +    aspeed_test_addresses("-machine ast2700-evb", 0x12070000, &as2700_masks);
>   }
>   
>   int main(int argc, char **argv)




