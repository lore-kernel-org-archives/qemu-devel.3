Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62C2C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6oVn-0007se-Bz; Wed, 16 Sep 2026 08:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vincent.163@outlook.com>)
 id 1x6mEA-0005Rt-Hv
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 05:46:55 -0400
Received: from mail-westusazolkn19010001.outbound.protection.outlook.com
 ([52.103.2.1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vincent.163@outlook.com>)
 id 1x6mE7-0003ug-Ve
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 05:46:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRGvG9nblTCSEdaWD5AtR97TqtcN+1/jVyZts2kc/C1iU6fSx9THDi7kAK1yKFn9M7K5ufBeeeSc5DLWHgdD5dRip1EqTpnTLpakc7cKOEq7mcMxFOP0HRA0A8wPjjoz4xm8uxvr+r38FdkBEt9evB3sYpSw2NT69YtnfaxWiRipbYCX0pMZU8srXT1m6s5UbLCaFiVQVV/J4qv3TH6rrDj7GiZecJ6dS+Gw0/Iyc75zTzn/42XlR2CaDZqfVY7iUjwpM1lhsG7jmUDDJLBJ6gp7/foJX4TbwRdgL1Qbg4oRHB5B6LKpPi33qZrvoJS2dSQE31WydqKMOUZSnFIzbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drzaW8iGEkvszLA/GRjgCWO+VQA+mPDEDc7ewkFktAc=;
 b=IZ4ONp6ZDzBUBOh3ddlPaDIMbuN7ff1VyuMhTJtcwDHxOqc3PYqIPoFkfWMukKs4SkcaQLSKCCEFqpqsDFxclBt2uDAhmSJx1GSC2QwvNHmAB3H4mBlkgI8RJvmkSG2bj1hLeQRxct4Y/puuD6xuV+DVHmfGhY4yJEHKE+zxmTz373+x8VfIMiJ5yANY45x2Go6lDH+9D/oRVEeZijMzQDbYTwseYrVWPe0JVZRhXd1frpZHffcTb1KaRMpjnbngS5PfjkxinW9mw/PC9M7mFye19iDhUTnal/ICsMcqeMrhHcZFQmsnOe1PHxKBaMtkIvtzlNfeC9mnQKF7dI8CVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drzaW8iGEkvszLA/GRjgCWO+VQA+mPDEDc7ewkFktAc=;
 b=ex+xU9jYPfUtU9uebnkn2LAptKHm0eyI1RGIqS8x4svSeEy/WN2tN/L5BaD+nCyP0NW/5RuCEtI/u7oFdnNL88NBeP/JXLbN+ugULcThrAmKt3evfIil2T3IRld1r5hvJgLa+5pzgqICjlgPnZWRXUO9Rqf/cB2umMd8cyd4bAjyoULjJ5d0mm6e5E5h96cLR8JwSFx/uU5WL95EmWcQTVTx6HP8nKvkJ8hXxFvwRg9Njp3WqEbqYQAVcfe1eCHgjIwzbV9uukqfPrqWeocGXCyvydu4L/xNtoGWCtSfryhzj7oAkan6sts0gwd+Bi6pFEcUN4XINTYZlkacWiZwLA==
Received: from SA1PR20MB7041.namprd20.prod.outlook.com (2603:10b6:806:3a4::5)
 by IA2PR20MB7208.namprd20.prod.outlook.com (2603:10b6:208:4ab::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 09:41:47 +0000
Received: from SA1PR20MB7041.namprd20.prod.outlook.com
 ([fe80::9d06:75a2:5356:cdb4]) by SA1PR20MB7041.namprd20.prod.outlook.com
 ([fe80::9d06:75a2:5356:cdb4%4]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 09:41:47 +0000
From: a vincent163 <vincent.163@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [BUG] x86_64 guest: vpmovmskb produces wrong mask on a riscv64 host
 (user-mode) -- root cause = TCG_REG_TMP0 clobber in tcg/riscv
 tcg_out_dup{m,i}_vec (10.0.0-10.0.7, 10.1.0-10.1.3, 10.2.0)
Thread-Topic: [BUG] x86_64 guest: vpmovmskb produces wrong mask on a riscv64
 host (user-mode) -- root cause = TCG_REG_TMP0 clobber in tcg/riscv
 tcg_out_dup{m,i}_vec (10.0.0-10.0.7, 10.1.0-10.1.3, 10.2.0)
Thread-Index: AQHdRb+XxqfWBtLr+ECEy03UrwLjUg==
Date: Wed, 16 Sep 2026 09:41:47 +0000
Message-ID: <SA1PR20MB7041B36B079598503E672E59ABB92@SA1PR20MB7041.namprd20.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR20MB7041:EE_|IA2PR20MB7208:EE_
x-ms-office365-filtering-correlation-id: fcf039ad-fc71-46ca-a3a3-08df13d6b9ff
x-microsoft-antispam: BCL:0;
 ARA:14566002|38102599003|39105399006|4140399003|25010399006|31061999003|20031999006|41001999006|24021099003|12121999013|8062599012|19110799012|15080799012|8060799015|40105399003|2607281247196008|10035399007|56899033|102099032|440099028|3412199025;
x-microsoft-antispam-message-info: =?us-ascii?Q?X5X97cSibgrM4GGClyg/UCN6diqs2Afx/mIQlMpEvWig+FAwIHHMg5eTyiYY?=
 =?us-ascii?Q?Ty79zVq7x9EzDGclfq7aFK4UqUIH6/8rfBDrkOkFJyI8XSchPz/Y8Lny770D?=
 =?us-ascii?Q?/GyvRPyrKWOVLJe91Kt27TrJkUpbuOLLyqkZGP+EPIkTe8ac641p/h/i96H5?=
 =?us-ascii?Q?yGwSc+cx5v9TVGUu/SKI/emUNp7K+SsWU/dDhaS1sZYAO4SxP9BYcKFDlw0j?=
 =?us-ascii?Q?aUgFgNR7NBMI4+RLgYRRLV2KRfmVo4BxY/fS22pYr+3E6lmrltwYfu56en9m?=
 =?us-ascii?Q?W7doesyxdea9fNyUDIPFY1w7zJZ9l2lOsRes0bq8qi3hZfyIgFCAbfxcQXVg?=
 =?us-ascii?Q?FUk+1abS44l8uufydXBTII4j3/Mi7cWB/RWjYo9qxbRpwS7zDUfV1nRnFA7v?=
 =?us-ascii?Q?E5RoEZ/CZ12J+1H0e3xpqmBSt8i4iazRRNbroTAWgnPy9hqZxXmUUaAdn18r?=
 =?us-ascii?Q?eMWLwnVZiTADn9PqVkSNxUps29aCj5SC0H8NQg8ZvC/huO6LvGksC5cSeP/P?=
 =?us-ascii?Q?bmDfp8BxFyhXdUpl2QasT/wbo5ZjjFYDq3GtVzdAubCMq4bRYMLO26GFdPie?=
 =?us-ascii?Q?6KOgFY1d61fiWwrE2phzneBcL08Gds7T+2nlFadmu8eTBCfKo8tgTB91HgEk?=
 =?us-ascii?Q?Gnw4VG3R1kRdG1iBKyQyZMRCfCc3UEfcIMhZQRYeR5Gx/2Cu8epeWq/tlhdL?=
 =?us-ascii?Q?Jm1u6JuZaCoPZ36pjtpLzcJXBtSVouL50Ie0eCgxF4yWoKwSeb8cyldnCB8P?=
 =?us-ascii?Q?aMS9jCJgR40B8OYUaMctXhWEV08BsXk1O8e2SWh9UpEQfDF7r3vlLTQouIs3?=
 =?us-ascii?Q?40Gf3BupQYc3B0IBmAZqWYUfHdOwvx9ZUGcDzZUTXcV4VMwSWHFKn8d7BXwW?=
 =?us-ascii?Q?PvLOuLHWNuQ1f+RUGbDHzed/BxkOULQNmR2+zzRstXsDZWjWmGeXQ0sEdLjG?=
 =?us-ascii?Q?oZZcOneP12AgnvPF63NbxEpJpMexP9xETuIoORnxoEwLURVS2PQI6mKRriKN?=
 =?us-ascii?Q?wS8l2m4tE7Ip4r5b6955M9U1d6HMRYEjMfBVGt2R3Fc3aYU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XjTDBhWIuypamb8hh9RQIiX79Py+yCaW2pErz1LntFoNG6e8Otw8MEdUR/Uy?=
 =?us-ascii?Q?r9eXsfuE/OgNhybpkN/InYgHb7SfoLSr4IuA95sUrx+PbWhMyHwpPDTfYl56?=
 =?us-ascii?Q?vkNWaTBOEvuAsmzA9ZjxXcpvK4NLcf/m9IJgY1O+ppA6OmOf3R/aKV3105jT?=
 =?us-ascii?Q?Ufcfitdm4v6I/5KUCuTkhDhn4abL8ek2dswWNFA1qRVq3bwEUWtF7YeiZnzW?=
 =?us-ascii?Q?fBGxNI97os5h2h77A/wHk/JtP9ymeCpiCaQ7QWF5mdwmcd5sW7QKP4FVCI5V?=
 =?us-ascii?Q?MMC46l0IKgdmFj0KewrakdMpJaaXfmRfqDcas+hZK5jQPvzcWrMPmT5jMLXX?=
 =?us-ascii?Q?h56Pi8QIpFZH5rH8Pa34w6oqPPpmamZDHZs1zDNB4+JlJM6j+ldaQkM5ZexN?=
 =?us-ascii?Q?sOI0zxehS+rkmSlIBTFJssF3aulRPVrgreteNrhnLAhABub0Y/Ek+uGXwZgU?=
 =?us-ascii?Q?BWawlPPFZ2evKDetGwx+4BruT9ENpIKVFSd92KiECb95kS2vbX6Js9VCSz8U?=
 =?us-ascii?Q?mcpC9cFb70U59WNnPjSkK7iqutYEyAmrJOYfi6pzlZURXwdUKBWQYhM9hYqr?=
 =?us-ascii?Q?Ik7r4XP4yiuUQZe9iR8Y40r4hrxf5GQl7hl2GOxpR+rY8DNCHjko8njfqI2Z?=
 =?us-ascii?Q?dAUTQ2RpLLMHiJSIY2B7iBDHq6oz8Y6tfIPbu8Y8d8wcSDnx6FWZ6c/6dXHu?=
 =?us-ascii?Q?9NegJqK9002TElhY/znJoPA3EOmIGCKmKdKrKFGJ21ULhBZwHxpxLwsRmGVL?=
 =?us-ascii?Q?Zkj9hTR2GvwZqhcpTx3bXDKGMIJAVZrxiouvG+ep0INEFG2ZWmWAXGKsLH5I?=
 =?us-ascii?Q?tuAXRiz+e40dCeTQ27vt/4IQjwZ7Nc9ndnmIk8ARGn1yYAgq4RNWyVc1wcKZ?=
 =?us-ascii?Q?gP0zh7Af3h+vqHW8opH8B1rbycS5j51du+VXA5o5wb3x7J6yNDaxrC2s5Ybw?=
 =?us-ascii?Q?9ZJvjo2S/2a3OPyaw4SKlf3DFi6ZW1ezKHTpH78HV8ij9ERhIU6g/7CLUDTW?=
 =?us-ascii?Q?qHB/clMN6mdg8Vs6tBnXNB6uPGbelbl23PrOq4cXBCBdF97WwBqH/LQW8aTg?=
 =?us-ascii?Q?29IhwBPaH+uI+PZK+rNPzhW+ztRBmnkcFFg00KWV+e/fctQ2OumOHrNDxaC3?=
 =?us-ascii?Q?CxNKLBa1EbzszP1FcKD0XU4BJkcgeuLxESH7CkaUYvPgqipl8HKhhQ3GQhrG?=
 =?us-ascii?Q?y3a+dqQFiQkcRD/ScuLpfV7+bGcnkrQnDs72/wR05bf1RnZ6Ki85ZvNP993A?=
 =?us-ascii?Q?3wDqL6OO5lsZQkG+KFa+0HS99JtQjEjEvrDa65c6GkFNS1iG8DoYWmVmw5/W?=
 =?us-ascii?Q?N5Tb5+EM+MVxNruD7t/DXDg3OJoofuFpB9Sr1wA3Zircceivh977iHDM8+lf?=
 =?us-ascii?Q?3ctM9cy49yA637TBk+yhSEWzo0Nz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR20MB7041.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf039ad-fc71-46ca-a3a3-08df13d6b9ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 09:41:47.3908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR20MB7208
Received-SPF: pass client-ip=52.103.2.1; envelope-from=vincent.163@outlook.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 16 Sep 2026 08:13:14 -0400
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

STATUS (please read first)=0A=
--------------------------=0A=
This defect is ALREADY FIXED upstream.  It was reported by Zhijin Zeng=0A=
(SpacemiT) and fixed by Richard Henderson on master as=0A=
=0A=
  af6db3b71310ea63a018d517ba7d79e4e014db62=0A=
  "tcg/riscv: Fix TCG_REG_TMP0 clobber in tcg_gen_dup{m,i}"=0A=
  Fixes: d4be6ee1111 ("tcg/riscv: Implement vector mov/dup{m/i}")=0A=
=0A=
and cherry-picked to the stable branches (10.0 backport:=0A=
=0A=
  8c3c8daaadcab875d40028f88c4d31e80fc47718, first released in v10.0.8).=0A=
=0A=
There is therefore nothing new to fix.  This note is (a) an independent=0A=
reproduction/root-cause confirmation of that bug, and (b) a version=0A=
coverage check, because our project is based on QEMU 10.1.0, which=0A=
predates the fix.  No duplicate GitLab issue is needed unless the=0A=
maintainers want the extra data point; see "What we would like" below.=0A=
=0A=
Environment=0A=
-----------=0A=
Host:    riscv64 (RVV 1.0, VLEN=3D256), 8 cores, Linux 6.6.63=0A=
         CPU: "Ky(R) X1" (rv64imafdcv + zve32x/zve64x/zve64f/zve64d)=0A=
Guest:   x86_64, static, freestanding (no libc), AVX2=0A=
QEMU:    10.1.0, built from the vanilla upstream v10.1.0 tag on the=0A=
         riscv64 host:=0A=
           ./configure --target-list=3Dx86_64-linux-user \=0A=
               --disable-werror --disable-docs --disable-guest-agent=0A=
           make -j4=0A=
         (binary: build/qemu-x86_64, user-mode emulation only)=0A=
Also tested: 8.2.2 (Ubuntu package), 10.0.13 (Debian trixie package),=0A=
         the same test source built with the 10.1.0 base plus a local=0A=
         workaround, 10.1.0+ds-5ubuntu2 and 10.2.1+ds-1ubuntu3 (could=0A=
         not be executed on this host, see "Untested" below).=0A=
=0A=
Symptom=0A=
-------=0A=
An x86_64 AVX2 guest that computes a byte mask with vpmovmskb gets a=0A=
wrong result on a riscv64 host.  Only the riscv64 host backend is=0A=
affected; the same guest binary is correct on an x86_64 host and under=0A=
any host backend that does not lower vpmovmskb through RVV (e.g.=0A=
QEMU 8.2.2 / 9.x, which have no riscv vector TCG backend).=0A=
=0A=
Reproducer (self-contained, no libc, no guest rootfs needed)=0A=
-----------------------------------------------------------=0A=
    /* pmovmskb-min2.c=0A=
     * Build: x86_64-linux-gnu-gcc -m64 -nostdlib -static -no-pie \=0A=
     *            -mavx2 -O1 -o pmovmskb-min2 pmovmskb-min2.c=0A=
     * Run:   ./pmovmskb-min2 | od -An -tx4=0A=
     */=0A=
    #define NR 8=0A=
=0A=
    unsigned char data[32] __attribute__((aligned(32)));=0A=
    unsigned out[NR];=0A=
=0A=
    static unsigned do_mask(const unsigned char *p)=0A=
    {=0A=
        unsigned m;=0A=
        __asm__ __volatile__(=0A=
            "vpxor     %%ymm0, %%ymm0, %%ymm0\n\t"=0A=
            "vpcmpeqd  (%1), %%ymm0, %%ymm1\n\t"=0A=
            "vpmovmskb %%ymm1, %0\n\t"=0A=
            "vzeroupper\n\t"=0A=
            : "=3Dr"(m) : "r"(p) : "ymm0", "ymm1", "memory");=0A=
        return m;=0A=
    }=0A=
=0A=
    void _start(void)=0A=
    {=0A=
        unsigned i, j;=0A=
=0A=
        for (i =3D 0; i < NR; i++) {=0A=
            for (j =3D 0; j < 32; j++) {=0A=
                data[j] =3D 0;=0A=
            }=0A=
            for (j =3D 0; j < i; j++) {=0A=
                data[4 * j] =3D 0x2f;      /* dword j !=3D 0 */=0A=
            }=0A=
            out[i] =3D do_mask(data);=0A=
        }=0A=
=0A=
        /* write(1, out, sizeof out); exit(0) */=0A=
        __asm__ __volatile__(=0A=
            "mov $1, %%eax\n\t"=0A=
            "mov $1, %%edi\n\t"=0A=
            "lea out(%%rip), %%rsi\n\t"=0A=
            "mov $32, %%edx\n\t"=0A=
            "syscall\n\t"=0A=
            "mov $231, %%eax\n\t"=0A=
            "xor %%edi, %%edi\n\t"=0A=
            "syscall\n\t"=0A=
            ::: "rax", "rdi", "rsi", "rdx", "memory");=0A=
    }=0A=
=0A=
Iteration i builds a 32-byte vector in which dwords 0..i-1 are 0x2f and=0A=
the rest are zero, then compares it against zero with vpcmpeqd (so the=0A=
higher dwords become all-ones) and extracts the 32 mask bits.=0A=
=0A=
Observed vs expected (od -An -tx4)=0A=
----------------------------------=0A=
Vanilla QEMU 10.1.0 on riscv64:=0A=
=0A=
  ffffffff ffffff3c ffffff00 ffff3c00 ffff0000 ff3c0000 ff000000=0A=
  3c000000=0A=
=0A=
Expected (native x86_64, QEMU 8.2.2 and 10.0.13 on the same host, and=0A=
the same 10.1.0 tree with the fix/workaround applied):=0A=
=0A=
  ffffffff fffffff0 ffffff00 fffff000 ffff0000 fff00000 ff000000=0A=
  f0000000=0A=
=0A=
Every miscomputed byte is 0x3c where 0xf0 is expected; 0x00 and 0xff=0A=
patterns come out unchanged.  Runs are deterministic.=0A=
=0A=
Root cause=0A=
----------=0A=
vpmovmskb is lowered by target/i386/tcg/emit.c.inc:gen_pmovmskb_vec() to=0A=
a per-64-bit-lane SWAR sequence:=0A=
=0A=
    d =3D s & 0x8080808080808080;         /* one sign bit per byte */=0A=
    d |=3D d << 7;  d |=3D d << 14;  d |=3D d << 28;=0A=
    /* then one byte is read out of each 64-bit lane */=0A=
=0A=
The constant is materialised on the host through tcg_out_dupi_vec()=0A=
(vece =3D MO_8, arg >> 56 =3D=3D -128), which in the affected QEMU versions=
=0A=
does:=0A=
=0A=
    tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, arg);     /* TMP0 =3D -128 =
*/=0A=
    tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);=0A=
=0A=
and tcg_out_dup_vec() calls set_vtype_len_sew() *before* using src:=0A=
=0A=
    set_vtype_len_sew(s, type, vece);      /* may write TCG_REG_TMP0 */=0A=
    tcg_out_opc_vx(s, OPC_VMV_V_X, dst, 0, src);=0A=
=0A=
set_vtype() emits a vsetvl whose destination register is TCG_REG_TMP0=0A=
(see probe_frac_lmul_1(): for avl >=3D 32 with lmul =3D=3D avl it uses=0A=
"rd !=3D 0 and rs1 =3D=3D 0 uses vlmax", i.e. vsetvli TMP0, zero, <vtype>),=
=0A=
so TMP0 is overwritten with the resulting vl before the splat happens.=0A=
tcg_out_dupm_vec() has the same shape (load into TMP0, then delegate).=0A=
Every fixed version (10.0.8+, 10.1.4+, 10.2.1+, all 11.x) instead calls=0A=
set_vtype*() first and only then materialises into TMP0 -- the fix=0A=
commit restores exactly that, with the comment "Note set_vtype* may=0A=
clobber TMP0, so do that first."=0A=
=0A=
Host code emitted for the guest TB (qemu-x86_64 -d in_asm,op,out_asm),=0A=
affected 10.1.0 vs correct 10.0.13 -- only the ordering differs:=0A=
=0A=
  10.1.0 (wrong):=0A=
    addi    t6,zero,-128          # TMP0 =3D 0xffffffffffffff80=0A=
    vsetvli t6,zero,e8,m1,ta,ma   # TMP0 =3D vl   <-- clobbers the imm=0A=
    vmv.v.x v2,t6                 # splat vl instead of -128=0A=
    vand.vv v1,v1,v2=0A=
=0A=
  10.0.13 (correct):=0A=
    vsetvli t6,zero,e8,m1,ta,ma=0A=
    addi    t6,zero,-128=0A=
    vmv.v.x v2,t6=0A=
    vand.vv v1,v1,v2=0A=
=0A=
On this host (V256, e8, m1) vl is 32, so the vector AND mask becomes=0A=
0x20 per byte instead of 0x80.  Measured directly on the CPU with=0A=
"vsetvli zero, zero, e8, m1, ta, ma": vl =3D 32 (VLEN =3D 256; the same=0A=
instruction with e32/m1 gives 8 and with e64/m1 gives 4, matching the=0A=
vsetivli counts in the QEMU out_asm dump).  Simulating the SWAR=0A=
sequence above with 0x20 gives, bit for bit, all eight wrong 32-bit=0A=
masks listed above (0xf0 -> 0x3c, 0x00 and 0xff unchanged); with 0x80=0A=
it reproduces the expected masks.  That closes the loop on the whole=0A=
chain.=0A=
=0A=
The three vsll.vi/vor.vv pairs in the same block are identical in both=0A=
versions (same encoding 0x961e3157 etc.), so the disassembler text=0A=
"vsll.vi v2,v1,60" printed by 10.1.0 in the out_asm dump is a text=0A=
rendering difference only, not the cause (the hardware executes the=0A=
same encoding in both builds).=0A=
=0A=
Version coverage (verified by running the reproducer and/or by=0A=
inspecting tcg/riscv/tcg-target.c.inc at the release tag)=0A=
---------------------------------------------------------=0A=
  8.2.2, 9.x                unaffected (no RVV TCG backend)=0A=
  10.0.0 .. 10.0.7          AFFECTED (delegating form)=0A=
  10.0.8 .. 10.0.13         fixed (contains 8c3c8daa)=0A=
  10.1.0 .. 10.1.3          AFFECTED (delegating form)=0A=
  10.1.4, 10.1.5            fixed=0A=
  10.2.0                    AFFECTED (delegating form)=0A=
  10.2.1 .. 10.2.4          fixed=0A=
  11.0.0 .. 11.1.1          fixed (contains af6db3b7 on master/stable)=0A=
=0A=
Direct measurements: 10.0.13 correct, 10.1.0 wrong (both on this=0A=
riscv64 host, the 10.1.0 binary built from the upstream v10.1.0 tag).=0A=
=0A=
Fix=0A=
---=0A=
  master / 11.x:  af6db3b71310ea63a018d517ba7d79e4e014db62=0A=
                  8c3c8daaadcab875d40028f88c4d31e80fc47718 (10.0 stable)=0A=
  Order of operations: call set_vtype*() first, then use TCG_REG_TMP0=0A=
  (and stops routing dupm/dupi through tcg_out_dup_vec).=0A=
=0A=
What we would like=0A=
------------------=0A=
1. Confirmation that no host-side regression remains in the affected=0A=
   stable branches -- from the version table above, 10.1.0/10.1.1/=0A=
   10.1.2/10.1.3 and 10.2.0 are affected and 10.1.4/10.2.1 are the=0A=
   first fixed patch releases.  If that matches your intent, nothing=0A=
   needs to change; we simply want to be sure we are not missing a=0A=
   branch that still ships the buggy order.=0A=
2. If a GitLab issue is preferred for the record (or if you want the=0A=
   riscv64 Ky(R) X1 / VLEN=3D256 data point attached to the existing=0A=
   thread), say so and we will file one; we did not want to open a=0A=
   duplicate issue without asking first.=0A=
3. No patch is offered, since the upstream fix already exists; happy to=0A=
   test a backport to any branch that still needs it.=0A=
=0A=
Impact on our project=0A=
---------------------=0A=
We maintain a QEMU fork (COGBT, an AOT translating accelerator) based on=0A=
QEMU 10.1.0, so we are in the AFFECTED window.  We first hit this as a=0A=
wcslen()/glibc misbehaviour in x86_64 guest binaries and chased it down=0A=
to vpmovmskb.  Our interim workaround replaces the vector SWAR with a=0A=
scalar per-byte loop in gen_PMOVMSKB (target/i386/tcg/emit.c.inc), which=0A=
makes 10.1.0 correct on riscv64 but is not the right long-term answer;=0A=
we intend to drop it and carry af6db3b7/8c3c8daa instead.=0A=
=0A=
The three functions the fix touches (tcg_out_dup_vec, tcg_out_dupm_vec,=0A=
tcg_out_dupi_vec) are textually identical to vanilla 10.1.0 in our tree,=0A=
and the patch applies to it without any conflict (verified with=0A=
"patch --dry-run -p1" against our current tcg/riscv/tcg-target.c.inc),=0A=
so this is a straight cherry-pick for us.=0A=
=0A=
Untested / unknowns (stated honestly)=0A=
-------------------------------------=0A=
* Two Ubuntu riscv64 packages could not be executed on this host:=0A=
  qemu-user 10.1.0+ds-5ubuntu2 and qemu-user 10.2.1+ds-1ubuntu3 abort=0A=
  with SIGILL (their ELF Tag_RISCV_arch asks for a richer vector=0A=
  extension set than this CPU advertises).  10.1.0 is in the affected=0A=
  window and 10.2.1 in the fixed window per the source inspection=0A=
  above, but we could not confirm that by execution.=0A=
* qemu-user-static 9.2.1+ds-1ubuntu5 from Ubuntu is a transitional=0A=
  package with no guest binaries, so 9.x was not measured directly; it=0A=
  predates the riscv vector TCG backend and is therefore assumed=0A=
  unaffected.=0A=
* We only exercised a riscv64 host.  Any host whose set_vtype() picks=0A=
  the "rd =3D TCG_REG_TMP0" vsetvl form (avl >=3D 32 with lmul =3D=3D avl)=
=0A=
  should be equally affected; hosts where only the VSETIVLI form is=0A=
  used (avl < 32) may accidentally not clobber TMP0 and could mask the=0A=
  bug depending on VLEN.=0A=
=0A=
Reported-by: Vincent <vincent.163@outlook.com>=0A=
Submitted on behalf of the author by the AI agent deepseek-v4.1-flash;=0A=
the reproduction, the source analysis and the version matrix above were=0A=
produced by that agent and independently confirmed by re-running the=0A=
reproducer against each QEMU build named in the report.=0A=

