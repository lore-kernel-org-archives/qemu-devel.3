Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744FDC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtggg-0002u9-A2; Tue, 11 Aug 2026 03:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wtggV-0002tA-IK
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 03:14:05 -0400
Received: from smtpout5.mo537.mail-out.ovh.net ([51.210.91.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wtggS-0003Bu-P4
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 03:14:03 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4hK2sw0wNjz49s8;
 Tue, 11 Aug 2026 07:13:55 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 11 Aug 2026 07:13:55 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.188.111])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hK2sv3382z1y5q; Tue, 11 Aug 2026 07:13:55 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 5DFD41B43EE1;
 Tue, 11 Aug 2026 07:13:53 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G0058fba1e6b-8bfd-4f93-9603-1d5eb5aec354,
 803E6BE66494CDF3CD1430A16CDAFD105E03C239) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <3dd84c94-cfd3-490c-8f4f-08d896bc6b4f@kaod.org>
Date: Tue, 11 Aug 2026 09:13:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/16] Support the ASPEED HACE crypto command
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 14678075611103407149
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFzUtbYltJcBOkzHQlPb4WmPGOy0X1Q1oKsPda3Z3i6FfB+EVYhvu1K5ENy7n9S0VjxuWrAJXZtGRhJ8Sud5Kgf7kWNEDhfKVXKtXCqxSiQrXU/dboakQnxBBP6NH6/SYkcLWy+UddGYEMAwHaSaL7yCZ5khqmKX/6LUjI0UHoDniLJFE4r5NJHV+4tzao9vJYjbf2/PBhA/bLFTLtpC1C9gLWb9fSFTqJQmYPo/ehc6Pz/3OU9cpJDG/3+L6Stq45GhTZwkCZut0qCIh1EOMSrFVoDfn1MqKWg3LBxTBERyIeW0bl+YoivhxtA40vL+ArmXHuLK8/2FRIQfV/RooFNXtxygRA0WUemlpXzPKoIvKUDfKcr9JhDdidowTc45Fl9HlY1TZRtEw3aq4LoO4PzWOfM6aFC7O8EUmhkVZFPWiOUDw4CpIFfbNKrAkxnN2ES7ceA7tWOTxqFrRdk20euZyk+rfl2jP8NbU2lm6TMbQhZkMvPeb6VxJB5lEOGCSsN6kYbgetJEvCBUYeYi0QmQ5nnU0z7B8boQN2vKxagRZyOC8TZ1BRL6OR5+TO14QB1b8QfjJ9Vr6wlrt7NDNXPKp5arnIyO2MlGxLbSQ4E1A1HnapJ7BegaRgnbr+r2GyWhxaxFc0EpAc9GVQkYTAOKIqgM5Cq4B+QNmr22DhwSQ
DKIM-Signature: a=rsa-sha256; bh=nDiAZ9hgWSqA1Z7XMeq0u03xPt4fCwv2d6/pSkCtSTs=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1786432437; v=1;
 b=s8TqOEKEjdiFfc1j/c/bnFbneh0qeGxEntFlNuTCfVEOuE1/yqGKj2ZntyZUROv+QmVOcSAx
 nMjEbStAUB2K+2+LB/NLSAxQiT5pI9El5wwo10AxCPBEfqZk4apI9Yo9I2GGkx5/v73afpQrcnj
 qdIXDzjP61tt9MTRQLteWNNmphI3YIvVpTa/R09ZVxZW606vgzdi50fzM8+IpeR9kzWiZjsD0uw
 eYs04U07AM4PJZu+kWGpLznvjf856PPPxauJD9LKwZdrpJ1YyGzn1c9TrLw2JDfMHbD/LYR+dWS
 6mKKTbFFP1i8QtybnyWcx0hRS1bx1d2aBxRcrBkDBeJXQ==
Received-SPF: pass client-ip=51.210.91.24; envelope-from=clg@kaod.org;
 helo=smtpout5.mo537.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/11/26 08:01, Jamin Lin wrote:
> The ASPEED HACE model only emulated the hash command; the crypto (cipher)
> command was stubbed out. On the AST2700 the kernel runs the crypto driver
> self-tests at boot, so without crypto emulation booting floods the log
> with failures:
> 
>    root@ast2700-default:~# dmesg | grep "self"
> [    6.078446] alg: self-tests for ctr(des) using aspeed-ctr-des failed (rc=-22)
> [    6.079295] alg: self-tests for ctr(des) using aspeed-ctr-des failed (rc=-22)
> [    6.089924] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes failed (rc=-22)
> [    6.090629] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes failed (rc=-22)
> [    6.100134] alg: self-tests for cbc(des3_ede) using aspeed-cbc-tdes failed (rc=-22)
> [    6.100416] alg: self-tests for ecb(des3_ede) using aspeed-ecb-tdes failed (rc=-22)
> [    6.100576] alg: self-tests for cbc(des3_ede) using aspeed-cbc-tdes failed (rc=-22)
> [    6.101411] alg: self-tests for ecb(des3_ede) using aspeed-ecb-tdes failed (rc=-22)
> [    6.152954] alg: self-tests for ecb(des) using aspeed-ecb-des failed (rc=-22)
> [    6.153701] alg: self-tests for ecb(des) using aspeed-ecb-des failed (rc=-22)
> [    6.180101] alg: self-tests for cbc(des) using aspeed-cbc-des failed (rc=-22)
> [    6.180747] alg: self-tests for cbc(des) using aspeed-cbc-des failed (rc=-22)
> [    6.206437] alg: self-tests for ctr(aes) using aspeed-ctr-aes failed (rc=-22)
> [    6.206910] alg: self-tests for ctr(aes) using aspeed-ctr-aes failed (rc=-22)
> [    6.215313] alg: self-tests for cbc(aes) using aspeed-cbc-aes failed (rc=-22)
> [    6.215698] alg: self-tests for cbc(aes) using aspeed-cbc-aes failed (rc=-22)
> [    6.227173] alg: self-tests for ecb(aes) using aspeed-ecb-aes failed (rc=-22)
> [    6.228027] alg: self-tests for ecb(aes) using aspeed-ecb-aes failed (rc=-22)
> [    6.276878] alg: self-tests for gcm(aes) using aspeed-gcm-aes failed (rc=-22)
> [    6.277541] alg: self-tests for gcm(aes) using aspeed-gcm-aes failed (rc=-22)
> 
> This series implements the HACE crypto command: AES/DES/3DES in ECB/CBC/CTR
> over direct and scatter-gather DMA, and AES-GCM with 64-bit DMA on the
> AST2700. It also adds GCM to the qcrypto cipher API (gcrypt backend) that
> the AST2700 path needs, plus qtest and unit-test coverage.
> 
> With crypto emulated the self-tests pass, the warnings above disappear, and
> the temporary 'cryptomgr.notests=1' boot workaround in the AST2700
> functional tests is dropped.
> 
> Note: the GNUTLS crypto backend does not support AES-CTR mode.
> 
> v1:
>    1. Support the crypto command in direct access mode
>    2. Support scatter-gather mode for the crypto command
>    3. Support the AES-GCM mode for the crypto command
>    4. Support 64-bit DMA for the crypto command
>    5. Test the crypto command
>    6. Drop the AST2700 crypto self-test/model workaround
> 
> v2:
>    1. Add AES-GCM to the nettle and gnutls crypto backends
>    2. Skip crypto tests for cipher modes the
>      compiled backend does not support, via qcrypto_cipher_supports()
>    3.  Check qcrypto_cipher_supports() before running a
>      crypt command and report the mode as unimplemented when the backend lacks it
> 
> v3:
>    1. remove the duplicate CRYPT_IRQ_EN definition.
>    2. remove the unuse CRYPT_CMD_DST_SG_CTRL definition.
>    3. Drop "Drop the AST2700 crypto self-test workaround" patch because GNUTLS
>       backend does not support AES-CTR mode.
> 
> v4:
>    1. Add GCM tag mask
> 
> Jamin Lin (16):
>    hw/misc/aspeed_hace: Support the crypto command in direct access mode
>    tests/qtest/aspeed-hace: Test the crypto command on the AST2500
>    hw/misc/aspeed_hace: Support scatter-gather mode for the crypto
>      command
>    hw/misc/aspeed_hace: Support the CTR mode for the crypto command
>    tests/qtest/aspeed-hace: Test the crypto command on the AST2600
>    tests/qtest/aspeed-hace: Test the crypto command on the AST1030
>    crypto/cipher: Add GCM to QCryptoCipherMode
>    crypto/cipher: Add setaad/gettag for AEAD modes
>    crypto/cipher-gcrypt: Implement AES-GCM
>    crypto/cipher-nettle: Implement AES-GCM
>    crypto/cipher-gnutls: Implement AES-GCM
>    tests/unit/test-crypto-cipher: Test AES-GCM mode
>    hw/misc/aspeed_hace: Support 64-bit DMA for the crypto command
>    hw/misc/aspeed_hace: Support the AES-GCM mode for the crypto command
>    hw/misc/aspeed_hace: Enable the crypto command on the AST2700
>    tests/qtest/aspeed-hace: Test the crypto command on the AST2700
> 
>   qapi/crypto.json                |   4 +-
>   crypto/cipherpriv.h             |   8 +
>   include/crypto/cipher.h         |  36 ++
>   include/hw/misc/aspeed_hace.h   |   1 -
>   tests/qtest/aspeed-hace-utils.h |  20 +
>   crypto/cipher.c                 |  32 ++
>   hw/misc/aspeed_hace.c           | 461 ++++++++++++++++++++-
>   tests/qtest/aspeed-hace-utils.c | 693 ++++++++++++++++++++++++++++++++
>   tests/qtest/aspeed_hace-test.c  |  18 +
>   tests/qtest/ast2700-hace-test.c |   9 +
>   tests/unit/test-crypto-cipher.c | 240 +++++++++++
>   crypto/cipher-gcrypt.c.inc      | 101 +++++
>   crypto/cipher-gnutls.c.inc      | 154 +++++++
>   crypto/cipher-nettle.c.inc      | 128 ++++++
>   tests/qtest/meson.build         |   6 +-
>   15 files changed, 1886 insertions(+), 25 deletions(-)
> 

Applied to

     https://github.com/legoater/qemu aspeed-next

Thanks,

C.


