Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D45310AB837
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5vNk-000090-1j; Thu, 26 Mar 2026 20:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5vNc-00008d-7Z
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 20:48:52 -0400
Received: from p-west3-cluster6-host10-snip4-4.eps.apple.com ([57.103.75.97]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5vNY-000077-Qt
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 20:48:51 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPS id
 265851800131; Fri, 27 Mar 2026 00:48:43 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774572526; x=1777164526;
 bh=jBUm/YWne7SdaxKkzucIB51pQCJFwoZe0Ji2oCAmznM=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=IAGowcy64tBPmwe+nLP4Zj6qUahk6Yt8avzueVgNuHXxH62DcuJ8AX9szKIbWoyYqQSmJHDkFBi9Kmf0IeAQLdts5ddVFK55BTPgRRUFmipviWmStt1WPFrPlHIDZ2e0ndwHm1HYwNKlKMVtE9711dFb02omYyAslyeQdwpD3rZ6g61BvF5jEiEcfwPWQicW0hpHzLhvJWjKXVdDI0nyFi4/EgRyVw+5NbdJqYjn0qivejWnQIbkEyYJR9vJvAP0MgljO+Tk2DloZOP/v0SVhPjElsgbYAEfr5iBnFs40hkD2OWvXz86aiFzbzCcPcpRXbGbaSeNHeNUTBaOEH8AYQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPSA id
 588B618000AB; Fri, 27 Mar 2026 00:48:41 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v5 3/6] target/i386: emulate: remove redundant logging for
 unmapped MMIO access
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <6a000434-cebb-4076-8350-32f7baf48493@linaro.org>
Date: Fri, 27 Mar 2026 01:48:28 +0100
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5B4AB65C-64C1-45FE-89C6-3081AC815045@unpredictable.fr>
References: <20260326233130.59392-1-mohamed@unpredictable.fr>
 <20260326233130.59392-4-mohamed@unpredictable.fr>
 <6a000434-cebb-4076-8350-32f7baf48493@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=SvGdKfO0 c=1 sm=1 tr=0 ts=69c5d3ed
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=nKRBnGPCAAAA:8 a=KKAkSRfTAAAA:8
 a=KI15JDLDVkQ8Q8-Noq0A:9 a=QEXdDO2ut3YA:10 a=JhrwjW1jOIvqYJKOqOMI:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: E3iNaolAJiv081yrFyvfQejwU2IWCKuZ
X-Proofpoint-ORIG-GUID: E3iNaolAJiv081yrFyvfQejwU2IWCKuZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwNCBTYWx0ZWRfX9U3hEukMzQd9
 QPPTyaJPnCOrXT0W0W99kDWWUlwrGgTPom3qcB5xdflpHPexq6GkGlVYUqlWRGUROcknyBMaBy1
 56El4JFyK46fXc1qXzDyMjWiTV5U8b4h88Fq/3S8X3wIjxfGXkmd0QwIej72JFTy/SxeFZNp5oX
 Mec0gz2/xgjKnNmnTVgvfmfNMnWC/l1hbefprpKIquv2MSoe12TUBcXuZ3paRtjB9B2D8AgTkVg
 vTRq77CI7SCHDd7bfEBmm4x1V5zYVL5B67xTL1SM3YUFNRznBckwrWuRubRA0zBImWoej3J/xay
 BIi+pIZKjsP9RgaYpUVZBnVWTC7T+MEIwoFwJMuiz1/7pOwlWrdGXUqWpt9ZYo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1030 mlxlogscore=952 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603270004
Received-SPF: pass client-ip=57.103.75.97;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 27. Mar 2026, at 01:38, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>=20
> On 3/26/26 4:31 PM, Mohamed Mediouni wrote:
>> ReactOS's install ISO does a bunch of 4-byte accesses
>> to 0xffdff124. This doesn't happen for the boot ISO.
>> It looks to be an access relative to the Windows KPCR
>> which is at 0xffdff000 but mistakenly done prior to
>> paging being on...
>> As this logging is redundant with -d invalid_mem,
>> remove it.
>>=20
>=20
> It's not obvious why it's redundant, I don't see another mmio write =
path from exec_movs_single.

Hello,

It=E2=80=99s a bit long but it gets there :)

For example on the read path:

exec_movs_single -> read_val_from_mem -> read_mmio -> x86_read_mem

x86_read_mem_ex -> address_space_read -> flatview_read_continue or =
address_space_read_full

address_space_read_full -> flatview_read -> flatview_read_continue -> =
flatview_read_continue_step -> memory_region_dispatch_read -> =
memory_region_access_valid

and memory_region_access_valid raises that error message with -d =
invalid_mem

And on the write side it=E2=80=99s fairly similar, with it ending on =
memory_region_access_valid
at the end.

It=E2=80=99s a bit of a labyrinth though.

>=20
>> =
https://geoffchappell.com/studies/windows/km/ntoskrnl/inc/ntos/i386_x/kpcr=
.htm
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  target/i386/emulate/x86_mmu.c | 3 ---
>>  1 file changed, 3 deletions(-)


