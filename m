Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4592CD66B9A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVwvy-0005dI-ES; Wed, 17 Dec 2025 14:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVwvv-0005bw-Jq; Wed, 17 Dec 2025 14:11:35 -0500
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVwvt-00013K-LH; Wed, 17 Dec 2025 14:11:35 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id D3BD1EC004F;
 Wed, 17 Dec 2025 14:11:30 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 17 Dec 2025 14:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1765998690; x=1766085090; bh=qf
 ImsTZgWyi8Wv+VrPK1hOHx30Est5+jvVOTcygWZ8w=; b=CAItpBGB3bxgKRfKok
 Lwm61EzkG4NbIZib+MKU/USufKdex9W6cwyW5D/qiXpRbxVuMdQYfG34tzysHQcS
 lzaYztlA41ZaAIjBUNjvjgEkp8rgqKKbiKw/APjCXvJvQS1mHJoBCJT0Ybt9aByz
 vqhZ941Bjjfx1MQKZGB19yWKDYCYUbpX1mTTUfYDjtVf8nAsDyI1VmQMp28BmcOc
 me/kCMFUMLDveYLhSyHhtJ3gBTNuT3POCCGSn7UX/r07Zn/pXnTMpXMcbBRtNt/8
 kSy9trHYfRajhwS50ZsXcozJMfmDp2v/tancdTie6TeUNi01FL8zPnTjPCOFUiMj
 jH4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1765998690; x=1766085090; bh=qfImsTZgWyi8Wv+VrPK1hOHx30Es
 t5+jvVOTcygWZ8w=; b=O3Iu3a5sW/Fr7A47Pyuxktkyy4W6OjOBFfu6Wwo0LTBs
 djx9yi+f35o+9Fb77BjOmcd0DluHZxosaU6uIkrCJkMJM4sFHV6w0FpvAZVqDk0f
 XKHsmaMZrANFKz6RtqK0tL8r3bbycD49NFEdzfGc4eRVqBuj/BOwJPi4yuAG6pCW
 P3GHB2qDAlT71t8vrAFEaEX9BVUUtVU/Bp29HnXgQUeTkh5attEDxZnk5sNUAvCL
 Sg161edAp+UwH/75I4SfLY8Gd93S3Ah506DA4J8yc1ZuQ3tmEreCZVIGrlCCB9WI
 VuY5PeBMdm/Pfc07q8PCKh7FlRAQ71w5v4V2So26yw==
X-ME-Sender: <xms:YQBDafzN0d21Y98zsFdqQdW1Cj0JWRliokkYULoA51Obzd7N5juuHg>
 <xme:YQBDaaUdKo7iEIBQiYnIpL7NqcJWt0QhsFgpkbOLKO2CWQClBhrI_868zl2nE96ZG
 GcRcXw6mcIvSjGsuWIzDBUAPXMnc08tvDgBf4_KuPwiRKrifZC5RQ>
X-ME-Received: <xmr:YQBDaT-1yiTy7i3-QK0WLZgXJe4ILlneye0MCRHQwmWeApMIALSBR5k8p2M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegfeefjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
 cuvffnffculdejtddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecu
 hfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghksehsthiftg
 igrdighiiiqeenucggtffrrghtthgvrhhnpeefuddvfeehhffgveelheejheefvdfhtdet
 ieelgfehtedtgeekleejhffffedvleenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
 grmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiiipdhnsggprhgt
 phhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrthhrihgtkh
 esshhtfigtgidrgiihiidprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhn
 rghrohdrohhrghdprhgtphhtthhopehsthgvvhgvnhgplhgvvgesrghsphgvvgguthgvtg
 hhrdgtohhmpdhrtghpthhtohepqhgvmhhuqdgrrhhmsehnohhnghhnuhdrohhrghdprhgt
 phhtthhopehjrghmihhnpghlihhnsegrshhpvggvughtvggthhdrtghomhdprhgtphhtth
 hopegrnhgurhgvfiestghouggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghpthht
 oheplhgvvghtrhhohiesghhmrghilhdrtghomhdprhgtphhtthhopehqvghmuhdquggvvh
 gvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghu
X-ME-Proxy: <xmx:YQBDaVs9PFowb0jwukMYS2pIIGY8V3ADVtXriqAMgM-ZPqHBBAz-ug>
 <xmx:YQBDab1Kapjk-oL_CrIxDjAl5db-grzFThjNZRJrTHwflPthD4ISUQ>
 <xmx:YQBDaSSxFfP4PDZ2VNRz2DOmr4TqjcT-81PzGVt_qhLA0uvd0tlC3Q>
 <xmx:YQBDaXeGDQwJSDz6lZWz4zhc69AwIhy6o3jHOP7XYZtR3Q2Q5OePHg>
 <xmx:YgBDaUKogbRlfX1ETbzb0XW3h-2HW3AnrQcfxaZ59_-s40sKINieyd7t>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 14:11:29 -0500 (EST)
From: Patrick Williams <patrick@stwcx.xyz>
Subject: [PATCH 00/11] hw/arm/aspeed: catalina: add eeproms images
Date: Wed, 17 Dec 2025 14:11:27 -0500
Message-Id: <20251217-catalina-eeproms-v1-0-dc7b276efd57@stwcx.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF8AQ2kC/x3MQQqAIBBA0avIrBPUsLKrRAupqQZKRSMC8e5Jy
 7f4P0PCSJhgZBkiPpTIuwrZMFgO63bktFaDEkpLJXu+2Nue5CxHDNFfiSut10GItjNGQs1CxI3
 efznNpXx9qiNMYgAAAA==
X-Change-ID: 20251217-catalina-eeproms-255d80036991
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Patrick Williams <patrick@stwcx.xyz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3244; i=patrick@stwcx.xyz;
 h=from:subject:message-id;
 bh=fXOOrFT2puVO0ueEXyGoaTqM8WhIlRDA/MI35QjYPEI=;
 b=owEBbQKS/ZANAwAIAasDR8wtAMEZAcsmYgBpQwBfYCxzBQ9hQUbquMkUsNnFuYrypC7guo3lV
 +/3NZd7ln6JAjMEAAEIAB0WIQQEYP2KLgsT1w1uokGrA0fMLQDBGQUCaUMAXwAKCRCrA0fMLQDB
 GTNIEACY/FdGSrZG1LzGWVWz82dpLvSQlhJxEdeTnr0rGzRP34yeZ8f37yaq8j2/fAoSS9yCJd2
 BnDFwZlVtm7q4zvtRJWQGLZApoJiEgAfLYkWuLfUzX9coESZRWCCpbXZHSnjKbziXg1N2MNROMn
 Sx1ICV5+0MJ8KJ4I/64BnvidNFb2EIeulcbMkvGPXiLHbjZ/lOA0NfEOcZ7D1b54LI8zfBYcB/i
 MP4qKqzI4WeTyLj2Q0f2/w7uwyOU5+2yWxz6tPS6/iTn3A5jmwVjn0291+EMJKvSkjfRcun7brZ
 bN1IIS3aZcuGxbjccMwVVRsSREUVsoaUGUGeL8CrJO7A/qJyYZNyRPczNOCVC1tFtRZZDUfZwuy
 nY7Vc7NoQDuhVz4ZfMwWYeYbIUzkCthilYewEUhU0dkuGIR6NmL0iM4Rfg28LCc5BG4HoSvCyQy
 o6o3PcwoyLcbfEliilM5cuBXgbKzWDlwDjtYy9kTlbmrGTQ92Jkw84sTrjgOrDd0MpvNI+P/7m2
 Pwl+XkxA9TsbhywZlA8mUZFxrQYkJN5qCSfWdvWcEbGLdvvCYsPQYRUN/nnOGqgSDJ5VCto3V0m
 k6FMGxFV9dPHxbr0ZFtVutJ+sfG+a+r+EsEEemR6W2+FQoMwTfxUCQwz4qPcWXU9+ZzqZNvzdv9
 JMGiKuvpMrI2ETA==
X-Developer-Key: i=patrick@stwcx.xyz; a=openpgp;
 fpr=0460FD8A2E0B13D70D6EA241AB0347CC2D00C119
Received-SPF: pass client-ip=103.168.172.151; envelope-from=patrick@stwcx.xyz;
 helo=fout-a8-smtp.messagingengine.com
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.498,
 FROM_SUSPICIOUS_NTLD_FP=1.997, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Since Catalina is a server, made up of a number of FRUs, there are
a number of EEPROMs that would contain IPMI-format FRU data.  On
OpenBMC, these EEPROMs are parsed by `entity-manager` to determine
which devices are physically present in the server (and which variants
of those devices).

Add EEPROM images for every FRU in the Catalina server.  There is a
utility `frugen` which can take a JSON representation of the IPMI
fields and generate a binary image from that.  Use this to create
sanitized EEPROM images for every FRU and add the rom-init calls to
the appropriate locations in the Catalina model.  I left the JSON
source as comments along-side each EEPROM image so they can be updated
or recreated as necessary.

Tested by loading the latest version of OpenBMC's Catalina image and
confirming the FRUs are detected appropriately by entity-manager.

```
root@catalina:~# busctl tree xyz.openbmc_project.EntityManager | grep "board/[^/]*$"
          |- /xyz/openbmc_project/inventory/system/board/BMC_Storage_Module
          |- /xyz/openbmc_project/inventory/system/board/Catalina_FIO
          |- /xyz/openbmc_project/inventory/system/board/Catalina_HDD_Carrier
          |- /xyz/openbmc_project/inventory/system/board/Catalina_HDD_NVMe
          |- /xyz/openbmc_project/inventory/system/board/Catalina_OSFP_Carrier
          |- /xyz/openbmc_project/inventory/system/board/Catalina_PDB
          |- /xyz/openbmc_project/inventory/system/board/Catalina_SCM
          |- /xyz/openbmc_project/inventory/system/board/NVIDIA_Cable_Cartridge_0
          |- /xyz/openbmc_project/inventory/system/board/NVIDIA_Cable_Cartridge_2
          |- /xyz/openbmc_project/inventory/system/board/NVIDIA_GB200_0
          |- /xyz/openbmc_project/inventory/system/board/NVIDIA_GB200_1
          |- /xyz/openbmc_project/inventory/system/board/NVIDIA_GB200_IO_Board_29
          |- /xyz/openbmc_project/inventory/system/board/NVIDIA_GB200_IO_Board_41
          |- /xyz/openbmc_project/inventory/system/board/NVIDIA_HMC
          |- /xyz/openbmc_project/inventory/system/board/OCP_CX7_NIC_10
          `- /xyz/openbmc_project/inventory/system/board/OCP_CX7_NIC_15
```

This result matches the expected results when running the image on a
physical Catalina device.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
Patrick Williams (11):
      hw/arm/aspeed: catalina: add BSM FRU EEPROM
      hw/arm/aspeed: catalina: add DC-SCM FRU EEPROM
      hw/arm/aspeed: catalina: add PDB FRU EEPROM
      hw/arm/aspeed: catalina: add OSFP FRU EEPROM
      hw/arm/aspeed: catalina: add FIO FRU EEPROM
      hw/arm/aspeed: catalina: add HDD FRU EEPROM
      hw/arm/aspeed: catalina: add GB200 FRU EEPROM
      hw/arm/aspeed: catalina: add GB200-IO FRU EEPROM
      hw/arm/aspeed: catalina: add HMC FRU EEPROM
      hw/arm/aspeed: catalina: add NIC FRU EEPROM
      hw/arm/aspeed: catalina: add Cable Cartridge FRU EEPROM

 hw/arm/aspeed_ast2600_catalina.c | 473 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 457 insertions(+), 16 deletions(-)
---
base-commit: 7154e4df40468012fccb6687ecd2b288c56a4a2d
change-id: 20251217-catalina-eeproms-255d80036991

Best regards,
-- 
Patrick Williams


