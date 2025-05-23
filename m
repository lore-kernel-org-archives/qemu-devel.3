Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68175C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 08:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uINUZ-00033X-Lq; Fri, 23 May 2025 04:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fO70=YH=kaod.org=clg@ozlabs.org>)
 id 1uINUX-00032h-Vb; Fri, 23 May 2025 04:10:57 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fO70=YH=kaod.org=clg@ozlabs.org>)
 id 1uINUU-0002aA-76; Fri, 23 May 2025 04:10:56 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4b3dBz4cWcz4xfL;
 Fri, 23 May 2025 18:10:51 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4b3dBv0vl8z4wyR;
 Fri, 23 May 2025 18:10:46 +1000 (AEST)
Message-ID: <b019315b-be90-4b1b-837a-76c31e41c893@kaod.org>
Date: Fri, 23 May 2025 10:10:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/28] Fix incorrect hash results on AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250515081008.583578-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250515081008.583578-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=fO70=YH=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/15/25 10:09, Jamin Lin wrote:
> v1:
>   1. Added support for 64-bit DMA in the HACE model
>   2. Refactored the do_hash operation in the HACE model
>   3. Fixed a crash caused by out-of-bound memory access in HACE
>   4. Added more trace events and implemented dumping of source hash data and
>      resulting digests to improve debugging
>   5. Refactored the HACE QTest framework to support both AST1030 and AST2700
>   6. Added a test case for SHA384
> 
> v2:
>    1. Create new helper functions
>       hash_get_source_addr
>       hash_prepare_direct_iov
>       hash_prepare_sg_iov
>       hash_get_digest_addr
>       hash_write_digest_and_unmap_iov
>       hash_execute_non_acc_mode
>       hash_execute_acc_mode
>    2. Refactor do_hash_operation
>    3. Fix review issue
>    4. Revise trace-events
>    5. Move register size to instance class and dynamically allocate regs
> 
> v3:
>    1. Split patch to introduce these routines one by one :
>         hash_prepare_sg_iov
>         hash_prepare_direct_iov
>         hash_execute_acc_mode
>         hash_execute_non_acc_mode
>         hash_write_digest_and_unmap_iov
>    2. Fix run qtest failed
>   
> This patchset resolves incorrect hash results reported on the AST2700 platform.
> This update addresses the following kernel warnings and test failures related to
> the crypto self-test framework:
> 
> aspeed-hmac-sha512 test failed (incorrect result)
> aspeed-hmac-sha384 test failed (incorrect result)
> aspeed-sha512 test failed (incorrect result)
> aspeed-sha384 test failed (incorrect result)
> aspeed-hmac-sha256 test failed (incorrect result)
> aspeed-hmac-sha224 test failed (incorrect result)
> aspeed-hmac-sha1 test failed (incorrect result)
> aspeed-sha224 test failed (incorrect result)
> aspeed-sha256 test failed (incorrect result)
> aspeed-sha1 test failed (incorrect result)
> 
> How to test it
> 
> Use the following command to dump information about the supported digest methods
> via the ast_crypto_engine hardware engine:
> 
> root@ast2700-default:~# openssl engine -pre DUMP_INFO ast_crypto_engine
> 
> Digest SHA1, NID=64, AF_ALG info: name=sha1ALG_ERR: , driver=aspeed-sha1 (hw accelerated)
> Digest SHA224, NID=675, AF_ALG info: name=sha224ALG_ERR: , driver=aspeed-sha224 (hw accelerated)
> Digest SHA256, NID=672, AF_ALG info: name=sha256ALG_ERR: , driver=aspeed-sha256 (hw accelerated)
> Digest SHA384, NID=673, AF_ALG info: name=sha384ALG_ERR: , driver=aspeed-sha384 (hw accelerated)
> Digest SHA512, NID=674, AF_ALG info: name=sha512ALG_ERR: , driver=aspeed-sha512 (hw accelerated)
> 
> The status of SHA1, SHA224, SHA256, SHA384, and SHA512 should be marked as
> hw accelerated, indicating that these algorithms are supported by hardware
> acceleration via the aspeed drivers.
> 
> Create a test file on the host machine and compute its HASH value as the
> expected result
> 
> Create a 256MB test file
> 
> $ dd if=/dev/random of=/tmp/256M bs=1M count=256
> Generate Hash Values Using SHA1, SHA224, SHA256, SHA384, and SHA512
> 
> Use the following commands to generate HASH values for a 256MB file using
> different SHA algorithms:
> 
> $ sha1sum /tmp/256M
> 7fc628811a31ab87b0502dab3ed8d3ef07565885  /tmp/256M
> 
> $ sha224sum /tmp/256M
> 2d261c11ba05b3a62e0efeab51c307d9933426c7e18204683ef3da54  /tmp/256M
> 
> $ sha256sum /tmp/256M
> 5716d1700ee35c92ca5ca5b466639e9c36eed3f1447c1aec27f16d0fe113f94d  /tmp/256M
> 
> $ sha384sum /tmp/256M
> fb6bc62afa1096dcd3b870e7d2546b7a5a177b5f2bbd5c9759218182454709e0c504a2d9c26404e04aa8010a291b7f1c  /tmp/256M
> 
> $ sha512sum /tmp/256M
> fbceda7be34836fe857781656318ecd5b457a833a24c8736d5b8ef8d07e1950eebcdb140eebe4f12b5ff59586f7eb1c64fa95869c63dd9e4703d91261093c5c9  /tmp/256M
> 
> Generate HASH Values Using the Hardware Engine
> 
> Use the following commands to generate HASH values for a 256MB file using
> various SHA algorithms with the ast_crypto_engine hardware engine:
> 
> root@ast2700-default:~# openssl dgst -sha1 -engine ast_crypto_engine /tmp/256M
> Engine "ast_crypto_engine" set.
> SHA1(/tmp/256M)= 7fc628811a31ab87b0502dab3ed8d3ef07565885
> 
> root@ast2700-default:~# openssl dgst -sha224 -engine ast_crypto_engine /tmp/256M
> Engine "ast_crypto_engine" set.
> SHA2-224(/tmp/256M)= 2d261c11ba05b3a62e0efeab51c307d9933426c7e18204683ef3da54
> 
> root@ast2700-default:~# openssl dgst -sha256 -engine ast_crypto_engine /tmp/256M
> Engine "ast_crypto_engine" set.
> SHA2-256(/tmp/256M)= 5716d1700ee35c92ca5ca5b466639e9c36eed3f1447c1aec27f16d0fe113f94d
> 
> root@ast2700-default:~# openssl dgst -sha384 -engine ast_crypto_engine /tmp/256M
> Engine "ast_crypto_engine" set.
> SHA2-384(/tmp/256M)= fb6bc62afa1096dcd3b870e7d2546b7a5a177b5f2bbd5c9759218182454709e0c504a2d9c26404e04aa8010a291b7f1c
> 
> root@ast2700-default:~# openssl dgst -sha512 -engine ast_crypto_engine /tmp/256M
> Engine "ast_crypto_engine" set.
> SHA2-512(/tmp/256M)= fbceda7be34836fe857781656318ecd5b457a833a24c8736d5b8ef8d07e1950eebcdb140eebe4f12b5ff59586f7eb1c64fa95869c63dd9e4703d91261093c5c9
> 
> The HASH values generated here should exactly match those computed on the host
> machine using sha shell commands, verifying both the correctness of the
> hardware-accelerated results and the functionality of the ast_crypto_engine.
> 
> Jamin Lin (28):
>    hw/misc/aspeed_hace: Remove unused code for better readability
>    hw/misc/aspeed_hace: Improve readability and consistency in variable
>      naming
>    hw/misc/aspeed_hace: Ensure HASH_IRQ is always set to prevent firmware
>      hang
>    hw/misc/aspeed_hace: Extract direct mode hash buffer setup into helper
>      function
>    hw/misc/aspeed_hace: Extract SG-mode hash buffer setup into helper
>      function
>    hw/misc/aspeed_hace: Extract digest write and iov unmap into helper
>      function
>    hw/misc/aspeed_hace: Extract non-accumulation hash execution into
>      helper function
>    hw/misc/aspeed_hace: Extract accumulation-mode hash execution into
>      helper function
>    hw/misc/aspeed_hace: Introduce 64-bit hash source address helper
>      function
>    hw/misc/aspeed_hace: Rename R_HASH_DEST to R_HASH_DIGEST and introduce
>      64-bit hash digest address helper
>    hw/misc/aspeed_hace: Support accumulative mode for direct access mode
>    hw/misc/aspeed_hace: Move register size to instance class and
>      dynamically allocate regs
>    hw/misc/aspeed_hace: Add support for source, digest, key buffer 64 bit
>      addresses
>    hw/misc/aspeed_hace: Support DMA 64 bits dram address
>    hw/misc/aspeed_hace: Add trace-events for better debugging
>    hw/misc/aspeed_hace: Support to dump plaintext and digest for better
>      debugging
>    tests/qtest: Reorder aspeed test list
>    test/qtest: Introduce a new aspeed-hace-utils.c to place common
>      testcases
>    test/qtest/hace: Specify explicit array sizes for test vectors and
>      hash results
>    test/qtest/hace: Adjust test address range for AST1030 due to SRAM
>      limitations
>    test/qtest/hace: Add SHA-384 test cases for ASPEED HACE model
>    test/qtest/hace: Add SHA-384 tests for AST2600
>    test/qtest/hace: Add tests for AST1030
>    test/qtest/hace: Update source data and digest data type to 64-bit
>    test/qtest/hace: Support 64-bit source and digest addresses for
>      AST2700
>    test/qtest/hace: Support to test upper 32 bits of digest and source
>      addresses
>    test/qtest/hace: Support to validate 64-bit hmac key buffer addresses
>    test/qtest/hace: Add tests for AST2700
> 
>   include/hw/misc/aspeed_hace.h   |  11 +-
>   tests/qtest/aspeed-hace-utils.h |  84 +++++
>   hw/misc/aspeed_hace.c           | 479 +++++++++++++++--------
>   tests/qtest/aspeed-hace-utils.c | 646 ++++++++++++++++++++++++++++++++
>   tests/qtest/aspeed_hace-test.c  | 577 +++++-----------------------
>   tests/qtest/ast2700-hace-test.c |  98 +++++
>   hw/misc/trace-events            |   8 +
>   tests/qtest/meson.build         |  13 +-
>   8 files changed, 1279 insertions(+), 637 deletions(-)
>   create mode 100644 tests/qtest/aspeed-hace-utils.h
>   create mode 100644 tests/qtest/aspeed-hace-utils.c
>   create mode 100644 tests/qtest/ast2700-hace-test.c
> 



Applied to aspeed-next.

Thanks,

C.



