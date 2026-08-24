Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E4AC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyWbt-0002o9-MY; Mon, 24 Aug 2026 11:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyWbr-0002iY-L1
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:29:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyWbp-00007v-Fl
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:29:15 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OCuxha3053561
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QrirHpgzX0EzmRkKXSQIW/AR9dez9FULDlqeq1KD9Js=; b=UKigecBfiHnysfzv
 PC49ABrsAV7gPPfLSiROJvIIyuQ3iGLmJfH7pj0i9wh3gbgQ4eNZc5jZd1/cwIg4
 Bg4ATn4EKhlEylv11a/1FZsjtPfFotl1jNIrmMxNwXSHFSyyQOsoBkV9PEOgaeQ5
 /aREKFiknZxfbGMetANg4iQqIrLK+7nEnNDue45I3eMPVC+CLGqJZj0W3v0Ynx0+
 T5dbRgwWzs9RtlsDl6qTOWIUIpA3O/PT63qc/TBkNYkoY2J5CY60UK5ikuggGkkm
 oYBe7EGZroeOQJiAFopC5DC3e1x4CNOyu9Q0E52C7Af8AXiZpNxbgjnhxc0dtawN
 MTXhBQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88k7kjbc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:29:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so7895572a91.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787585348; x=1788190148; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QrirHpgzX0EzmRkKXSQIW/AR9dez9FULDlqeq1KD9Js=;
 b=AfNIOYnOAJ3ADjIWdAoFVp/nwZYnEtrqlRUf6RI419LF6SIMpWr/UVdw55DrFAyqTP
 si4+oWuiAOe3QbOFPzcWsLL/BFfojVozuU570m2GPRo5mUI3vvEqnJG7D6/uF/9jYJwz
 67wVWrDhaGstHD1GfjaVZOhFHGlVlsufONQfldPHy3Z48inTkS2BfX0O52h9EnA0QSAa
 ZYNxxqitiKGAHR00t2yMB4UiQLg3Hm0GAqFRkO0NGD2guWT8zVOy/GmjeL6VvH7Y06ch
 5Rhh30z5KYhSftaPCm3eXi4s4gn8tapTbVRWHAS0gLo5rO/E85jAlxt0Eym1LEb8CECX
 rrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585348; x=1788190148;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QrirHpgzX0EzmRkKXSQIW/AR9dez9FULDlqeq1KD9Js=;
 b=EsjtprcwCSjOm7nxI/VVhHT/plLTzo8S+lZ/GyyGdW1kq8V0dkJh1PRXNHfk0a/bi+
 FAXYsgXs8UCdHBsYSlhjfAVdSrObrFStaNaaN9X1rpQoV8pmdy/cv/CbWnpOztq4FYv3
 Xo7H4aYT3/jZ20LDejQR7VhWI3PGbOZiacQmt3qP62sLswRQ+3eq7AF8fOO4jPdawejD
 Rc8O4MFw5lJDtCglkc+pL5vO2VLKkS8qL6udEEB4Gq6xp++dDUMum2CStJS709cAESwG
 i9LqlZUiebkTNxnl2cirVuchFPFC0aMrYzspTwIYNtLBVCmSJAMoE1H+EyrZlJ1XtLHs
 VBOA==
X-Gm-Message-State: AFuF++kSXE/jeZlvEA6rfzDlg/xVHcos/PKIPZC84In0nBpV1A48QBPN
 pPPC0SfQFnKeh4Lyf58NhwBTSwk4WG/Si0zeYBYYsrXju2xWeSydQpscsfoPHeqAd8SUmwlt4z7
 9ZSPXQ9rSKLlvFstNi9ETxo+dD8PgRKkQ5OLovdW25zIXrAz4AaMp4FHDZA==
X-Gm-Gg: AR+sD10odiB3wU55W0s8tf4yYocW8Azq2iEZS2NVsFxOrksaucVabfpMaYP7osJ6JNw
 746WmcF5TTVPJeFMUYeOuJmDFfJ0LJqj3QvEoIClxdLCHsU+tOZfXRu57izcmJmvehHHRW/4Yrq
 cJJaQFfpOVGZTEbKeZQyVUedN1zN7tiYdHCVVSiYzgD3D6+pF3wCSOpjuxWKetNIWSPK6Rd1Afu
 M26INvTRa/dPK2qHFKnylTFfUD7endk9w3iPRKzrDFYMixAANihV7fAPRAnEi7BuQN6eFfQwPqT
 4j0HYJxX3V0q3riO7CPdTteuVjpmq/VGQOTsuSop5HatjRh7p0BUEMFUcsVZCTRcn8pCp7CxEXa
 c2tokTJVgTg7BqIGWA89s0FgtJoJJliuTrP1vZD4NixGbPFJEoBT2XvETM+6WI8cXyvpI
X-Received: by 2002:a17:90a:d404:b0:38e:ad9d:1161 with SMTP id
 98e67ed59e1d1-395decde369mr36152917a91.0.1787585347692; 
 Mon, 24 Aug 2026 08:29:07 -0700 (PDT)
X-Received: by 2002:a17:90a:d404:b0:38e:ad9d:1161 with SMTP id
 98e67ed59e1d1-395decde369mr36152845a91.0.1787585347181; 
 Mon, 24 Aug 2026 08:29:07 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141860ec7f7sm27606932c88.6.2026.08.24.08.29.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 08:29:06 -0700 (PDT)
Message-ID: <7a0247c9-781d-41f5-b7e7-35389117b1bd@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 08:29:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] qom/object: add available_if field to TypeInfo
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 philmd@oss.qualcomm.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, anjo@rev.ng
References: <20260821235112.193381-1-pierrick.bouvier@oss.qualcomm.com>
 <20260821235112.193381-2-pierrick.bouvier@oss.qualcomm.com>
 <87ld9wvyym.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87ld9wvyym.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=b4iCJNGx c=1 sm=1 tr=0 ts=6a8c6345 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=fazeBRwBIumJyVt8q6sA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzMCBTYWx0ZWRfX83lg44X+0vuG
 B8A4Q/MzoCW2vwrDMVBV28VeGLgj/QI4JOY1JFnAnHi612HkDRC76dkT+5dfN6WnscQpUE2Y0Ki
 UDVuq9BxSyzQqNukHirSAG109elzTGw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzMCBTYWx0ZWRfX9GfWyWQ6jofp
 3HFKK6micKfKw1ZHF5+yzVhZ8gK2Gjf4dPDJKHO0VkGvUtNaZZ+UnvnCmNAp8KQyGh6E79kNlzL
 WbKV2KLacvMru+guiSkAySAR9io7qIGymEW2Z0HHmvwG4WvsVjc9l5UyTM/EHszzf7MNtXcDGdW
 cuW+dWdcFNGBvPagTWr3xbNAGlMZSbXek4e/wRCkPY1W8eykIUtHHiJRrOKcrXkUpiZU04y2JzF
 fPdRsvL5zlvaRpX2TpPNmH+BrmEmWf3HymSroLEpRm14fL+rM8d9Cuq/533nA22kEb0RTVrw5OF
 725mj9v9AU42TZr15Y1N4dAfPKruKv+5EXg6483OYNn7EHIhcu+mWeUyp7VRyQv9XMEZBEzH48H
 sPKBpAmZvAIERnNneAZV6E5dZM/R792HkYTq01GnY7GK2pbUVDOGp70EmVvpNDB/4nwgRUEXveK
 4+xR9uXgtZQ7xm8bCCw==
X-Proofpoint-ORIG-GUID: OhkNvA-Q6b8jDF_GWeUNXpl5Fxsqbtgy
X-Proofpoint-GUID: OhkNvA-Q6b8jDF_GWeUNXpl5Fxsqbtgy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240130
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/23/2026 11:01 PM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> With the single-binary, we start mixing types for different targets,
>> that may or may not be available for current one.
>>
>> Previously, we implemented an approach based on interfaces, but it
>> proved to be too limited. It requires duplication between
>> machines/cpus/devices, and does not handle specific cases where a type
>> should be available based on a target configuration (Kconfig).
>>
>> To solve this, we add a new field, available_if, to TypeInfo.
>> It is an array containing a list of requirements for type to be
>> available.
>>
>> For now, we have only targets as requirements, but later we'll add
>> specific target config entries also.
>>
>> We also add a TARGET_REQS macro, to declare a list of requirements. For
>> sanity sake, we don't use a complex variadic macro prefixing each
>> parameter. It requires a lot of macro boilerplate in C, and prevent
>> readers to jump easily to definition for each parameter.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  include/qemu/target-info.h | 11 +++++++++++
>>  include/qom/object.h       |  5 +++++
>>  qom/object.c               | 10 ++++++++++
>>  rust/qom/src/qom.rs        |  1 +
>>  stubs/meson.build          |  1 +
>>  stubs/target-info.c        | 11 +++++++++++
>>  target-info.c              | 13 +++++++++++++
>>  7 files changed, 52 insertions(+)
>>  create mode 100644 stubs/target-info.c
>>
>> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
>> index 6c5b714288e..6379e65bbcf 100644
>> --- a/include/qemu/target-info.h
>> +++ b/include/qemu/target-info.h
>> @@ -50,6 +50,17 @@ const char *target_cpu_type(void);
>>   */
>>  bool target_big_endian(void);
>>  
>> +typedef enum TargetReq {
>> +    /* 0 is reserved for end of array */
>> +    TARGET_REQ_BASE_ARM = 1,
>> +    TARGET_REQ_AARCH64,
>> +    TARGET_REQ_ARM,
>> +} TargetReq;
>> +
>> +#define TARGET_REQS(...) (const TargetReq[]){__VA_ARGS__, 0}
> 
> The sentinel 0 is not a member of the enum.
> 
> Is this safe?  I'm asking because the C standard is infatuated with
> undefined behavior.  Checking C99...  all I can find is Annex I "Common
> warnings"
> 
>          -- A  value  is  given to an object of an enumeration type
>             other than by assignment  of  an  enumeration  constant
>             that  is  a  member  of  that  type,  or an enumeration
>             variable that has the same type,  or  the  value  of  a
>             function   that   returns  the  same  enumeration  type
> 
> Looks like it's safe.
>

As far as I know, it's safe as long as the value you set can be hold in
underlying type (in C or C++) chosen by compiler. Obviously, 0 is a safe
choice for any storage type.

That's also why the compiler will warn you a function having this
pattern misses a return value:

typedef enum {
  A,
  B,
} Enum

int f(Enum myEnum) {
  switch(myEnum) {
  case A:
    return 16;
  case B:
    return 42;
  }
  /* => missing return value after switch, add default: or assert(0) */
}

Regards,
Pierrick

