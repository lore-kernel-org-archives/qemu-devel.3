Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A9606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hHp+VloR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TReOoabd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4pu-0001Jz-HI; Mon, 16 Nov 2026 17:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4pr-0001J8-H4
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:05:59 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4pn-0007ID-R8
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:05:59 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfGgU2134904
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U8d4nVeLH36w9oYPVIb9u5RY5pAeu51tusH7lcQ2/yU=; b=hHp+VloRwGg6JuuL
 8SEnnyi7Beq1LlWF6RAzVPQPtG/ZYZgdyoT/w7zw4vwbfe98/Zu5u57onR6vU6fo
 pF5Zaxm2laTb13JWlOGLUExHS47QJeopzMFnQSPqW3Ae2IHLN5mL+ylfli7KiMBZ
 rGpKHIfugaPKwyjZ2DxKyOfSV8CgjvOpEkOkjUZeLAxfPARL1P6ORRj5XqgA1AWv
 vP56VrjPLW5SPFKo5dxkR0G1VV67akOFLJZoCQaAPrEMfFyWOyx9BL267g26eOZG
 2hc6tFSzuCFSE0TOtE0nZ44DT76FAS5/z0F6OCuEsr4LFmEIqQX4FFlrLP9HJWkI
 eI91CA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0003jpty-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:05:53 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-14373747468so1539392c88.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 14:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794866752; x=1795471552; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U8d4nVeLH36w9oYPVIb9u5RY5pAeu51tusH7lcQ2/yU=;
 b=TReOoabdVvxmT9ad620Mr7XCYSsLaxMHaVWLVl9HGJu8nLKLk3UUffAK8u009emtaJ
 u96H4ohtkfmsDQ6pLAa7q4Z5wHD27dAAuQN0Bdt9t5DHG4QG7U8Qped24+6fRu919WFW
 ldbenhr1e0xOW8zlRE91lok+3oyMt9Mzn53k8MJa+TBtWdrZlpLgA16ggrqGpklcu1uK
 E4RG3FAW3yoeq/zvlm/4TprxVJiQ07wpLDLADEUQa8nfqRM31FMx5FuCKxYE9HY5FsF1
 E1dJfhim9dmsUZ3Pj3WYAqNMYc90BpB50ircFwV2mZ52dMk2yhC8gD36TlHWYKNevcnR
 KYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794866752; x=1795471552;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U8d4nVeLH36w9oYPVIb9u5RY5pAeu51tusH7lcQ2/yU=;
 b=uyeC0iofSuvun5oaSetuZ3q02G7RY+pdiQrhlMEPl1eIuXflu3JQ8Wk6/K/Pi1h0Pc
 1M900/VNPXj4nXCE343g484pMDTUvIpOH0wIcDGyC/nvFf1EfEwj0ROGvRXwAuY4jnP3
 2oL9YHJfCGNcj1OiSKZoGE5QFSnKLvBBeqsBvlFchCJvHU4LutmKNfncNsQ/VKsqyWJh
 dvPNrd8aVE6JvHXXacoFGabRuN9BxCdNdthDRtf8aeLzTANKC7dpDFBepS50l6L8jf27
 5H4NA9BfS9wTwqn4jIf+FYPhsRQWI5/WeL0cUI5eNWPCg2DxsRWScL/vOx4uXBAiTHU5
 Xc+A==
X-Forwarded-Encrypted: i=1;
 AL+hErFes2t0/OYmhztaaPJPEp1InJ6/OPF30iLPs0bOQqvTiD2bstJSVwxE/6CCtIEDmrNIqMWU0Sl6KMPv@nongnu.org
X-Gm-Message-State: APuU4Z/VGb/zClM0mzQJ7AmNlbMYsCZfJoSEFfoPPnoSsvi32CU4VptQ
 2/YMuEvnPD/ZDt+jkMHwuyLgP0Lxr7HnQ17Bk3vAp5FIeYCX9Sn0GArjqny/LcjwNMJEY/r5/Xt
 +JwBMoPVGnCXjPTXv5ndU8MNE9a6T288FCJ4z3VCkfHuOx+VXsxOJGn7pBw==
X-Gm-Gg: AYBFou1P2YF0m5fapwVDHsfprfRkejm4msBjl5qWjocnvh97mpIfMa8hYWSz+CRdZUF
 siKy4jMNGDFndUWIfcre8PHR9K8VRVzM74BRUdsdtagiZefouDy7eTmH+c+KHCxkF1nJUQKMnVE
 TtkeftvPDTGPAGFHvi9hanE+w5LCa7nMwBM8eU6UHgpTiLbKJPD0AZhlmQZ+xjtUYevRA/J95QQ
 QUGrKyrRRrMuZJcRFsJ+YucbpIL8drgyUVu12BM0vALxIKUnDpHENpEOiffuE0mu9rD25gXTavm
 7ppwi68HvyFL43X71efZaYAU9oDH4nPotxL3SvVgBH6slhO94vLyVqgjf0OwKmppruKkWzsB/JA
 SKdmzj19Ljkoc1Ui42w41IxjgbNeo+9ToMz4COU9/P6vS/S0bBT+oDrz1qnEAg2rDSZQpeiCeTB
 RuvODX5h4ctKj5g31i6EGP+5d3XF30Q/1zUKPSeOqVRjs=
X-Received: by 2002:a05:7022:3c01:b0:1a7:7160:ffc8 with SMTP id
 a92af1059eb24-1b5030982b9mr10125535c88.10.1794866751996; 
 Mon, 16 Nov 2026 14:05:51 -0800 (PST)
X-Received: by 2002:a05:7022:3c01:b0:1a7:7160:ffc8 with SMTP id
 a92af1059eb24-1b5030982b9mr10125516c88.10.1794866751150; 
 Mon, 16 Nov 2026 14:05:51 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031bc518sm33037434c88.15.2026.11.16.14.05.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 14:05:50 -0800 (PST)
Message-ID: <5c7129b8-ff72-408f-a6db-9a629ba66f5d@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 14:05:48 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/48] qom: define an Aliased interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-5-berrange@redhat.com>
 <CAE2XoE8+=z+LcdqFWoLc=Ho8d7QGBgkJL8jL4cgup-o_X2fTrw@mail.gmail.com>
 <1447ca17-52a6-c069-d3b0-f778c60dca20@eik.bme.hu>
 <avt7apWvO-6QwI_u@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <avt7apWvO-6QwI_u@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YVqAhllmufrXi6tY-xBWTM9cYUzs__fH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfXzv0Uvp2/J4Ko
 6aY5hBhBSArWQUDwF4YWMcjlbkWp/SbWpyjN2l5sQpQnvNJUOsef9V4p/w+CDtL3Meh/DTISjlW
 lWzDSgm6AxS1+MQ4txUIcs5r0w2LjOE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfX0+lrVyXgtUHX
 ZP7zL9O4djfFiNVJBGZW1Avz4rMRoZD4qL+L1JiM9jeOVRnkjyAwJmFoA2mh+32e4LuRw/q5Eo4
 0PtgJHUQ51aj1Cwc0BBOGXFeNJb7xEMbQZufQRBpKEgPTHF6xlGNvGccjDpQw5VIkyL40o57mdH
 PCPELP4LVXWPQ3NEW4E7zxtN0ahUVPT93Fp1hlhS3fwckKuTsVOcajfnQOGaLQ8dHlN1/tEfCl1
 YWdYIK36eGgrxhTLWUInhkgWS36emF49lj6cmo8L2Uu7bioZNqWjjumdVwsnjRrqzB/tE2sTIYo
 IMVTlu4NSPV2p4vti+CVUgoBgV8vD7IOKmmt0ypJEF1KAnP4jhB456fb/+aEZx4LyfuoZ0eTk4j
 gQv2BZyBXlMbbrvCSkhwkmLqN3msiiERiBN9MOjNMEKgGaLpVXEwLVTkECXFwbeZ4EEZryWd4ak
 P6qU+MK4sfWDFcPvHoQ==
X-Authority-Analysis: v=2.4 cv=Z4N5j3RA c=1 sm=1 tr=0 ts=6afb7e41 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8 a=d4K9vK87SxXmuRG7Fe4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: YVqAhllmufrXi6tY-xBWTM9cYUzs__fH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160088
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/2026 1:53 PM, Daniel P. Berrangé wrote:
> On Sun, Nov 15, 2026 at 04:31:01PM +0100, BALATON Zoltan wrote:
>> On Sun, 15 Nov 2026, Yonggang Luo wrote:
>>> On Thu, Nov 12, 2026 at 9:31 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>
>>>> All QOM types must have a globally unique typename, however, for
>>>> user convenience, some might also want to have aliases which are
>>>> permitted to be ambiguous. Define an "Aliased" interface which
>>>> can be implemented by types which want to support aliases.
>>>>
>>>> When resolving an alias, if there are multiple QOM types with a
>>>> matching alias this is considered an error. Ambiguity can be
>>>> resolved by matching system state, with the selected target
>>>> being the currently implemented filter.
>>>>
>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>> ---
>>>>  include/qom/object_interfaces.h | 77 +++++++++++++++++++++++++++++++++
>>>>  qom/object_interfaces.c         | 57 ++++++++++++++++++++++++
>>>>  2 files changed, 134 insertions(+)
>>>>
>>>> diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
>>>> index d222a3d7481..010e37d63f7 100644
>>>> --- a/include/qom/object_interfaces.h
>>>> +++ b/include/qom/object_interfaces.h
>>>> @@ -27,6 +27,17 @@ DECLARE_CLASS_CHECKERS(TargetSpecificClass, TARGET_SPECIFIC,
>>>>
>>>>  typedef struct TargetSpecific TargetSpecific;
>>>>
>>>> +#define TYPE_ALIASED "aliased"
>>>> +
>>>> +typedef struct AliasedClass AliasedClass;
>>>> +DECLARE_CLASS_CHECKERS(AliasedClass, ALIASED,
>>>> +                       TYPE_ALIASED)
>>>> +#define ALIASED(obj) \
>>>> +     INTERFACE_CHECK(Aliased, (obj), \
>>>> +                     TYPE_ALIASED)
>>>> +
>>>> +typedef struct Aliased Aliased;
>>
>> I wonder if it would be simpler to add the possibility to define aliases to
>> all QOM objects as standard instead of by an interface? This is useful for
>> other cases, it came up here too for example:
>> https://lists.nongnu.org/archive/html/qemu-ppc/2025-02/msg00113.html
>> Or maybe this could be done with this interface by common super classes
>> implementing it such as device and machine allowing aliases that commonly
>> need it to use it but then it would be quite widespread use to consider just
>> adding it to object right away which may also help interaction with arch.
>> Why separating it into an interface is better when we need it for most
>> objects?
> 
> We really don't need it for most objects. It is somewhat common for
> machine classes, just because we have many called 'virt', but even
> they are a minority of all machines. The number of places we might
> need it outside of machines will likely not exceed single digits.
> 
> The core QOM framework tries to be a fairly "pure" object model
> without QEMU specific aspects to its design. It is somewhat
> inspired by GObject, and I still rather regret that QEMU is not
> using GObject as it would have done everything we need and made
> life easier.
>

I guess QOM predated it?
I always thought QOM was made by secret C++ lovers who couldn't use the
language in QEMU.

> Stuff that starts to get QEMU specific is pushed into interfaces
> like UserCreatable, or abstract base classes like "Device". IMHO
> it is beneficial to retain this conceptual division, as it lets
> us understand the behaviour of QOM as a framework in isolation
> from the bulk of QEMU.
>

That seems like a good rationale about what to implement where. It's
more debatable about having an interface or a machine field though.
I personally like the interface concept for this, even though it comes
with extra verbosity.

> With regards,
> Daniel


