Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359AF606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=AjzQPUg5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNfBt-00075Y-RA; Sun, 01 Nov 2026 18:42:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xNfBr-000759-Mf
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 18:42:19 -0500
Received: from st-2003j-snip6-4.eps.apple.com ([2a01:b747:3001:200::5f]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xNfBp-0006mA-8C
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 18:42:19 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPS id
 D03BD1800226; Sun, 01 Nov 2026 23:42:09 +0000 (UTC)
X-ICL-RepId: 01a1997d-eee0-70be-84e8-dcbfeaaef538
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0KWFsIWwQPH0wMUQJCBVZeSgwdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDjMATwErAC0CXXo5cikaX3AzClUKVXJdH0B4SXJZdC8FQHw7ci1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793576532; x=1825112532;
 bh=iSryCHl6qWv5VmvaFXPSDSRN2FMUTBxmvFf62RIzX3E=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=AjzQPUg56dTMaIk/ohhr3Lpc+fnBWSZK/lG956YQoEXCUYmUPJ+c4B8mOpSG/fnEZnWj0J4slDH3XWHtHGFJNPehnuopvJ0eMw6udAuzLWoRGg2L3QWlISqWwAebmttPyLPR7MNhxqjPyvKjg3RmBxDFofZd0xmxuTxBRLJEI3n7KOpMcKn6HfFJ+WJrxYh2oS42D18swwiFtY4LWwHn+InNa5hWs74zhYq84qGJQi+kt8KKQUgcQpw8kWJ25lM+Pwk14Hi3BTipW4YGbicn0aRrV13wbIS23JmAQ7vJGgS17Qy7OSLt/zZI17Tm9+Gs1j5JdMWqxrtjTvM1mLme5A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPSA id
 640D31800119; Sun, 01 Nov 2026 23:42:08 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: Qemu qurt and fastrpc?
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <aue3t9EKkoeb0FnG@gallifrey>
Date: Mon, 2 Nov 2026 00:41:55 +0100
Cc: brian.cain@oss.qualcomm.com,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C972F7F0-CAAD-4BC3-98E6-0A1A4CD70ECA@unpredictable.fr>
References: <aue3t9EKkoeb0FnG@gallifrey>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-ORIG-GUID: rB19hvxhcyKK1d_FCYiCgOsYzED7XHM_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA5NCBTYWx0ZWRfX8JEid9T8J5gS
 EPEZ6nWY5emvreXtFWQGEpAWfAVDf+AhzEjSWSAdvvOfotocKGvmbTQngZjMXZLGJnD+oIcBbcw
 Cnq5LWy9CbLnLh4FICUJZYq4O7b8WPbUGHbxMqdQAzxnutxBIUyyixh/tLutKqKrdZbAg93vkpz
 9e86tzfV24n6Q11LKbr8gmV5AUn8uUqErvnqRcZz93tpuF3B9n8crU8vqLTK/dRBLKpqw465HP5
 izeuwH+eQfGr8wMbcM/iDHiNTDuRxKrx9ySytOzrA9DXq8+oRIrhJKXkuNJGjzR5Y5w8x+XgacU
 w6Vw4Ut0FD6TtDyohZRqsTAXJJbAeeA5PP0KrgXOXmm66FurZZcRO6dpnXCAMw=
X-Authority-Info-Out: v=2.4 cv=BpeQAIX5 c=1 sm=1 tr=0 ts=6ae7ce52
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=qC_FGOx9AAAA:8
 a=3WJfbomfAAAA:8 a=_xDdhpmNWSdOSigtvkgA:9 a=QEXdDO2ut3YA:10
 a=fsdK_YakeE02zTmptMdW:22 a=1cNuO-ABBywtgFSQhe9S:22
X-Proofpoint-GUID: rB19hvxhcyKK1d_FCYiCgOsYzED7XHM_
X-JNJ: AAAAAAABkz8WNgFlihITAkSBxiA8MwF9USkeXBDSNsClmFGYADXGYDm8J+Xb/X9ifjf/tV
 qh2vN38cX1MWceGKILg2eVB7OVod3Geec3HmdaY95Iw+jIKL+6wlAG/ocGMUPdkUI0EutK
 /2D8jUphQRemj5IIgfo7tECtZE0ZB0ZIl0D8W8wSwNfDsUbzoBJmFCawraibPJ+WzlJMXh
 SwP3OS999b98YEhOMCvbXV9L7eCAl6sreDeGhjt8DCoZ1Voi6B8F4c1HfPzV/cWy1Yq9Vf
 wcTirA2qJzZMwANW3TsWpQh9W1HKqNAtRbFt1+oqa3dLVNJ+ar4f2c7SHVBe971SEK156n
 atzAHXwlGh0m7vFex97YO7mIiCSEhR9kIbKCI6x0fpXF3f5qfxooAnw1vTHR+Niws2qMQd
 FbZZ76hGa3m+20qzPcj/AuPDyy/JTtmqQyXFUlRL+UjYurzXPIZEOMPp3qEjThV2Sez8Ef
 muRSvQbcGscNWNe1Acwwgx7oS5QZN4xpptAbp1CwXL8eJrPSl5lZtIjwxjWHzm4qgorrK7
 CtQa8LyzVvhvuqtXanVxPQrMUo88j+xMVOj6ot976s3DL6Ip9p5cSWy9x3eGj9DqE+cTIq
 QtKDj2GfYPdlh5NGOg1QhmpHL1uDlMemZHcFtGItCEJV1MHR/BmTLU60Dz+l80IkK901Bx
 3tRdYTuY7kjOyz28/qc/6/b1gT0b1faGY7vwtz/TpEsurMhl+QZsG/MBcm/37ckkcbhGAv
 mjJNStkAjDG6ovhm/oFhTkvCW6ov2ApEZ1D4dVVBAZsRnzaIDZ35TwqGRegQHmswMDCm7V
 IdwFFkyewEhk0arzGSAFf0fKM5vcb/XT5M4qPJR0XJl6jIUwctphZu7DXmD15Im3fXiWXR
 BdfFhuynTi1Pfdznd/7qMt0CJcfMbcIm0tb8DqewnK7LgcvfHe6Q8Q5rkRZZT3QAaq1O/R
 gi/+pINJxh046b88iS7R5GJsS0iWOSIubZoh6AwaxDPZ4lfJVSGblWgAe8uBtazhmHNwOu
 mjg3c9JUUSNREfe49uIjIzmnzBRVAEQdFl3xk5re+/vCtrb5hMBiLZEJI1sSzvsM3G3V7f
 OZipyHj6kjI6pHt+vVRiPVPawSzs2yajQPRxt8Lqm+pd/9k317mP+F+Q56wCWHta5xgl7u
 2P6KKbYOlV1GZuJkgq82QYqmWXTHPue3lA0HCD/rr3cXxGOy8tkUnCqeAZk9ikLa/cjBKm
 RrG2hHP6RCLe71hFIDFFUcOJCNSv6cbDzZUS5ufk5nwdr87+rhzNhl6cgx+dYHjxISuvUS
 NfQuYEAfGboPDWlbBootw3/0aX/mKXlE9LqtGRFsC6YhI=
Received-SPF: pass client-ip=2a01:b747:3001:200::5f;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 1. Nov 2026, at 23:05, Dr. David Alan Gilbert <dave@treblig.org> =
wrote:
>=20
> Hi Brian,
>  I tried your hexagon support booting qurt images, very nice!
> I did:
>=20
>  ./qemu-system-hexagon -M virt  -kernel ./qccdsp8380.mbn -nographic
>=20
> and got something believable.
>=20
>  Do you have glue that lets you run comms to the emulated qurt via
> fastrpc in the same way that, say a Llama running on a normal
> Linux host would?
>  It feels useful for debugging/watching what maths kernels are
> doing.

Hi,

There=E2=80=99s no FastRPC=E2=80=A6 however:

You can download the Hexagon SDK from =
https://softwarecenter.qualcomm.com/catalog/item/Hexagon_SDK

That comes with a version of QuRT that is semi-hosted as runelf.pbn.

A working QuRT loading on top of that (w/ a semi-hosted -M option):

-kernel =
/opt/Hexagon_SDK/6.7.0.0/rtos/qurt/computev75/sdksim_bin/runelf.pbn \
-append =
'/opt/Hexagon_SDK/6.7.0.0/libs/run_main_on_hexagon/ship/hexagon_toolv19_v7=
5/run_main_on_hexagon_sim -- libmain.so'

The QEMU on Hexagon inside of the Hexagon also (used to) comes with an =
oddball QEMU Hexagon
version inside the package that has HMX emulation as a closed-source =
module, but that=E2=80=99s a
separate story that is going to be wound down thankfully.

If you don=E2=80=99t want to use the Hexagon SDK, there=E2=80=99s =
another option through hexagon-hypervisor which
has a very partial QuRT compat story. Or outright Linux on Hexagon which =
works too=E2=80=A6

The (modern) kernel tree for Linux on Hexagon being at =
https://git.kernel.org/pub/scm/linux/kernel/git/bcain/linux.git/log/?h=3Dh=
exagon

A pre-built artefact exists at =
https://artifacts.codelinaro.org/ui/native/codelinaro-toolchain-for-hexago=
n/23.1.2/qcs6490-cdsp/ with the booter at =
https://artifacts.codelinaro.org/ui/native/codelinaro-toolchain-for-hexago=
n/23.1.2/hexagon-hypervisor/

>=20
>  (Not urgent, I'm just trying to get my head around it on my
> X1 laptop)
>=20
>  Thanks in advance,
>=20
> Dave
> --=20
> -----Open up your eyes, open up your mind, open up your code -------  =20=

> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \=20=

> \        dave @ treblig.org |                               | In Hex /
> \ _________________________|_____ http://www.treblig.org   |_______/
>=20


