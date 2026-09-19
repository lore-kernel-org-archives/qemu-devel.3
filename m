Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00794C982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 00:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7itn-0002EO-8d; Fri, 18 Sep 2026 20:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x7itf-0002E7-U1
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 20:25:40 -0400
Received: from qs-2001h-snip6-11.eps.apple.com ([2a01:b747:3006:201::53]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x7itd-0004EM-8L
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 20:25:39 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-2 (Postfix) with ESMTPS id
 6EBC418000AA; Sat, 19 Sep 2026 00:25:31 +0000 (UTC)
X-ICL-RepId: 01a0b70d-d19b-7f84-8d81-da633bb74eb9
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0IShMFUgddTVYNRw9YHlwUFwlAQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0wMPnEsAC8CQRQ+cll0RgZDCkweVAMqcF14SHEsD1oCMQBKdix3HlwASx1XBFQfUxJVHR0LRVUSBEAIVlBUHkEEVhVsCVgGUxlX
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1789777532; x=1792369532;
 bh=hpQINkLgSDFacsH9826fI9ewwxv7IBAC1Gq7Pr/4TlE=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=k9Z7AMqNvcvPPNnzXXixwGjuh1hbwg6osexpvdqzxOUQLtGU8n2z4OglUtLiOiqdFQv+lofXaTFBEuROGxiEFk5WwLI1f0ihRktrFBuHv1A3VbY+lMOcwSJW8nWDUKnDOTuzgV7Ou3WCJAZRJq7eWTgvojqbP21ZoqM6Dyj9ci/l1TQ2WFtOsiIbvge0pbDRRNN6ut1vp2x8XNFku1MBrFIvzTkBfYKEgk7huAg6QsJhAMP76/zT9j1iRanrkO4WCQlBUr2lBzlS9f4pGnPsxxj3EjScQU+pb8cw9HZVZJ6Op1xUbXL64Kdzss+ql7QbJHblYfQo+Hphw+jTmZl+NA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-2 (Postfix) with ESMTPSA id
 A2833180051F; Sat, 19 Sep 2026 00:25:29 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH 4/4] agents: add CLAUDE.md and GEMINI.md
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <apf2gT5GBD6HZosQ@redhat.com>
Date: Sat, 19 Sep 2026 02:25:17 +0200
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Fabiano Rosas <farosas@suse.de>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5FBA7D01-FA4C-4334-94AB-A0BA810A92EA@unpredictable.fr>
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-5-pbonzini@redhat.com>
 <20260902054543-mutt-send-email-mst@kernel.org>
 <CABgObfacwO0bx+wc2s=5aiaEbQghvt-gZc77D6eDigf88mS1zA@mail.gmail.com>
 <20260902060604-mutt-send-email-mst@kernel.org> <apf2gT5GBD6HZosQ@redhat.com>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Proofpoint-ORIG-GUID: GOpqMupRDKJBhM6r1c9sAGdEiteSnpEB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDAwNCBTYWx0ZWRfXzuNVdM8KNgdf
 yjVoRGZpAcdGYBDUwcSuBTNqXixxGZ/Mh3DmOvaXFk+9hnyUJylpiGAHFEY3HpGkPuxb85gNTRN
 PSQEpdyB84b2NdHbjYYl8h4XGSTcE/kfuJwHbmdmDZLWas1qubJgUhyXELg/rz/bF+aAjPYMRgA
 SHRqLKMDU+GfogMo0Wn4qzmZusgIkXks+NWbcvOQ6+PBxKiBesXfLP3t37XKp16Raging+863Lw
 IUu2s8en8mVGheJY8q0/Ry8IAh38g1pPrWKokIV/fqL31xsh1LRQZ941v5E+lHX+BCyKfzXTsEd
 geNW1PV5tQq0H8DrZaekit97G7SPjz9TvEoaLCvSfh8jFJ3eNHZXIQscGj7DHU=
X-Authority-Info-Out: v=2.4 cv=d6j4CBjE c=1 sm=1 tr=0 ts=6aadd67b
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7cP8ZmXOAAAA:8 a=JI1JYfJhAAAA:8 a=E2OFlpCjAAAA:8
 a=vqL-DJG3AAAA:8 a=SqMvC5kiAAAA:8 a=J7Vs0gARAAAA:8 a=iXcLlBOuAAAA:8
 a=20KFwNOVAAAA:8 a=ualarqiqmNdT78Y7n_AA:9 a=QEXdDO2ut3YA:10
 a=VVqtDqBJJiCLDXf6LVOa:22 a=dooCaz2pC6urxjHRPqlL:22 a=l0t8tTNIJzRGstKQVvrs:22
 a=N5whb6oI2XAsh5LpMrx1:22 a=_o8VnCo6Hb5Oqlm6Mk7M:22 a=GK7RtA2AnwkbbjW1WRsD:22
 a=U82d2PgYpd_3u6iqMSvn:22
X-Proofpoint-GUID: GOpqMupRDKJBhM6r1c9sAGdEiteSnpEB
X-JNJ: AAAAAAABCrDhzZ65Zhf9W8yT+hHWxhQLgH7C4YJXE1Wb8ymfInwPRCPBAUdomrYJYn/m305MsPhdYOqOHp8Y08iKGr0pHc3Fzzd+jBL2ho6QqUmjCFXaYZyyAs/Mwa58Fkvnm6DUFOUTQflOWW65CYd90J6sJreBjD4qPKqqOaQCUP/O9UsLW/iUDVgG5+qYqWP3rhN5GnO4rljdpYT+PMHzzNaUavvBqtfzNU4dg+YqREs3HAV8dG4gKTZw/+BHhnMCAKGHNLjQWVW3J5PHFldgahpiAQRmuXB4ciZ6fOvLwew2GhqsCUL667ezOqyTP6OZ39Y5TLXKoBU+w9pzxIF7BF+ahFztxQUpW5tU2V8nfBc7PNPY60a7SKHNrCHa/IbP1yH5l4HUHyRFWDJY1OXfJ0s3m5f5JOos0xh5Sh/WI7tloNjwFM2sSQ4F0gfFxY5Tu36OrnSQSEIWeGJQdh/YBS4DZQ2x2mxhQMUXEILCCai0vOSDSXjlIOVfNUDhIjN8WLOWJDsqo5pc23LkNMaqZ8HDvZKW9aZffmFoYfPci43uabBidNvGpFxRjeKjyMtGjcLK/PI4cXRHVMAzYy4Bgio2p8hlH8dTk78jZSrPmPAo/jLUtmvjQYa2390GG3HZOl37YCXyyiszk7HinY4/u5oe0Nr7VYSwhu8j0ysIQrxtJXbp9QkoTmbZUzQPKtiJRTLAuzv8LulzzgzIOtFb38iImWSQUAYf+1htQDAiwMXzUtzU+Oy+f/LFKsexWKKYJ8SS6gIkHYOnPhAFGbJkNTBY70957hOJz9ZVKERsdilFiMwoiAytLZP54UFKVf46BaaigxjyoU6FKGr9Pq28fxRqaAivxB8l9Xgy7E+xmL4+h2llIFx2AAYYUTSzdIRS8/WGsiXwcTjBnVkNW6RVLw6XOH1BO2XKFSMwvgPRyeAldgOiSzMVY9PMz2vkyKhH8bPtaujjoZkge0KgL3azzU0K1/B
 wn6kkINuBG+PsmOxlqKf51+MAG6t9YdntwWwNKKhd8WfJJhFWEpayjL7tUUkJAHbmXIC/tSVnTC6+lfuTEHCvhXmI4eReWfK0+nd/MT/mXMiJtMZWJrYrDCwYcLso8A2iOonRd+4Y2ay9qdu9YSno/SgX1QWBUXjxrEAxQ7vBzAaE1nLoZtDi4f9YvhgCbGGk4fdZLuDEsbsLzvTq0riKfRsQhcgpF59FDghTrURGOBQyVl9Dg+pEMjYcpkvyxKwCPQ8BlQGxzUp+FlqVtwMBZ0y759OGaexmhOAm2KBHgAVITeWGHtDRsB0+RvPKOdKeBy3K1VANjcm82GuKL7aQiE518tjzWItdNxO3E5VjVKaW1ugOa4hsRkvNmNgu+E0oDr8/CcNJl+yNN9DWFlGevqukGFJV8/jkqhCYDqzwvYfgTeqgg4Si76gBQa69D9kqtKzSeMHcuCjBFNCdiWBa7PMcddXucksAd/4nW+L2wXnzpBfWt17CQzMzqjF7iiXR095WkXUmbY2O/slL9Z/ImHQihuAOcTTXekWfT8pPGRO6
Received-SPF: pass client-ip=2a01:b747:3006:201::53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 2. Sep 2026, at 12:12, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Wed, Sep 02, 2026 at 06:06:14AM -0400, Michael S. Tsirkin wrote:
>> On Wed, Sep 02, 2026 at 11:56:46AM +0200, Paolo Bonzini wrote:
>>> On Wed, Sep 2, 2026 at 11:46=E2=80=AFAM Michael S. Tsirkin =
<mst@redhat.com> wrote:
>>>>=20
>>>> On Tue, Sep 01, 2026 at 06:14:22PM +0200, Paolo Bonzini wrote:
>>>>> diff --git a/GEMINI.md b/GEMINI.md
>>>>> new file mode 100644
>>>>> index 00000000000..43c994c2d36
>>>>> --- /dev/null
>>>>> +++ b/GEMINI.md
>>>>> @@ -0,0 +1 @@
>>>>> +@AGENTS.md
>>>>=20
>>>> gemini seems to support agents.md - r u at the latest version?
>>>=20
>>> I tested and it doesn't load it for me.
>>=20
>> ok then sorry.
>=20
> It appears to be doable via a custom setting:
>=20
>  =
https://geminicli.com/docs/cli/gemini-md/#customize-the-context-file-name
>=20
> IOW, we could add a .gemini/settings.json that points it to AGENTS.MD
> instead of having a top level GEMINI.md file. Both are somewhat
> unpleasant given they're tool specific, but I'd have a slight =
preference
> towards the .gemini solution as dotfiles are a hidden files in many
> contexts.
>=20
> Similarly IIUC it would be possible to have a  .claude/CLAUDE.MD
> file instead of the top level one.

Hi,

https://code.claude.com/docs/en/changelog

> Added AGENTS.md support: in a project with no CLAUDE.md, Claude Code
> reads AGENTS.md instead; change it under =E2=80=9CProject =
instructions=E2=80=9D in
> /config (not yet on Bedrock, Vertex or Foundry)



>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange =
:|
> |: https://libvirt.org          ~~          https://entangle-photo.org =
:|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com =
:|



