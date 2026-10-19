Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E221460774FB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VJ0WNv8V;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PGqJjlVP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIpod-0001iU-Q6; Mon, 19 Oct 2026 12:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIpns-0001O7-LZ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:01:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIpnq-0007Mf-Kg
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:01:36 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFPRNS3115493
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 16:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QC9xCOK+f/jHXxb9ySYvKpqdWbzsq981kopxJgUWmKs=; b=VJ0WNv8VbS+H+h/u
 1NAHOZqZPnNmFGTMyX2Cbw1oHOwgUJ13aoeNDiBvJSCLpJctWMdhTyYyoAYq2wvS
 9K8CsqSrWYGERhhAVJMKqGPDG71RaasyCgNRTLmb39tPJPbR9p1xm2ynaLpKHPIp
 I0mOYwFrbLzV8NYQPcoURT2Mo3ItzU//Pql/uFA5y/g4OkJYJoP599w/xNOsP7+N
 BkRq1pgGO71ktRibvL3dMj089x9G8/D4FeQ/777916PxfDUMCc5O2ewWW3OH38Kj
 st/UTHD6abMhBGL0Y6grXuIGrNLGF58Gj9g3sMHmONs1Qyxei7YkmKVi6ik/lokw
 hTHYrw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5w1bmk1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 16:01:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510d0baf63so5852487eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 09:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792425692; x=1793030492; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QC9xCOK+f/jHXxb9ySYvKpqdWbzsq981kopxJgUWmKs=;
 b=PGqJjlVPzQVQamaqeakFwhe95ST1dPXisgy8FfHs0nUc4npLtr22PTC9oI542WBdjD
 FKTGL8K6xUVgb0EAMCX1PIhPJMSoeoRSAUQrS6Mandm9JPIUnbRx7K6mYpgYPFXus7HN
 gHJcXt0mAVnIlHnuKTwKIvBWBJONbayerkXRs9LKTJ1Z0cV1QC7TOxEV0tHGce0mVz1x
 CdR/igbfvR4R84ousHNcJvkRLIYACc12VFbK1un4wVsmN/jXApHi2odr0N22kUZT+osZ
 9EzPcMHUX4icLHSROBfgjjyz1eXNe7F/NxpKv7SGWo+mkukHud5+IlxxlGTx+54Odbno
 2NjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792425692; x=1793030492;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QC9xCOK+f/jHXxb9ySYvKpqdWbzsq981kopxJgUWmKs=;
 b=a8+JW0uSiaQgMFVQR3HT5nTmVJKVxM7L+UoexiGl+JwLwafDfzsbvasG2eqFacaCfr
 00B9H5LLLRHA/lgJgmGgI6zFaYjhtTQta//ctK9Dh9ea/XyLEZVVW6rYskgPVTU7hONZ
 V+sb8TKUDto5SEJTKxee/3ia3GhlJX7kh59tmIZoPc7bGC97l9thCZLZI5rb6UDgInTO
 X4BC+l7E456thRn66nehf3Jn2H8FemtL+qfycEKLRsZAxiGmG8xkquWeaxxT1VsvjRW8
 /8e09G597uwhHOJasme8mZ304uEPlEHaoRT2erDXpZiXDKBOYy4FJhu3unSZfDVieysp
 L7ZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzt2v0Fss6NbXByG/kBkDz3sa5ImSkBVWIa3idfPs/pDCwT8vKgMZZ7OehfB84TvbDkIzCkMcz4Oaf1@nongnu.org
X-Gm-Message-State: AFq9FYIyVCgQI4WFFZHE/+KsFXw6ZgWiTGG6KXyqqL00snI9xqYXuzpe
 +hKFnpjD4AFlmS3E+LWdz4bjMwuwgA+TLzyDCQbMLbDGkU/Aa/b6cQhICv1RbaeSnicppkrMoOc
 sX0hJGCZmqE2KUAQF4Xue7/ZfSfBHz5Np7XCWBH0yN/Eb1OItJdu6oWl4ZQ==
X-Gm-Gg: AYBFou0bhQxY0p0VtzyigdIlGtg0ZApqn+vuLJm5jA56H8/czlmgkTYmd0Pt0DBCst3
 2W5D1I6h9+1AWvjitzNSduVAS+pX+qBLEwVoChNY/UV3rlGukDtZZ7KYUhtx4A+mtu342JdRXkW
 Fb8D9DY5tN58dIM59/MT7vHKI12hefCvyuX+bRvJoT/OgrGd8CvIcqAEPXceWbfRHS9mFE4/NaZ
 AdoDKZK5bBJJjqtb/ji+0Vd1Qp/aBlYFzPSc3hJ8MMW7qPwLpv7bTE71Bx7sbPuPDsqDWx5DUGN
 4Ac1S2tJjEEDWqaHvaLc80ctJKDyMrMza0mtQMQOur13UHYkc767seQWcRlwT8U+U/kcRWRlwPN
 HRdjKwcxpyJ8aBFeSMLeqamQEnE6YkUBEm84cxjkIhwArU3LtJ2BxWgwhLvK1QRB+HoX+mg==
X-Received: by 2002:a05:693c:638d:10b0:359:8492:20ff with SMTP id
 5a478bee46e88-361a1270c4cmr10867488eec.12.1792425691550; 
 Mon, 19 Oct 2026 09:01:31 -0700 (PDT)
X-Received: by 2002:a05:693c:638d:10b0:359:8492:20ff with SMTP id
 5a478bee46e88-361a1270c4cmr10867456eec.12.1792425690814; 
 Mon, 19 Oct 2026 09:01:30 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36082784ec8sm31303112eec.22.2026.10.19.09.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 09:01:30 -0700 (PDT)
Message-ID: <bc7f368b-ffd3-467f-b1a0-fc03ba60ff6c@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 09:01:29 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Clarify 'query-kvm' deprecation release
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, kvm@vger.kernel.org
References: <20261018230305.6239-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261018230305.6239-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2MyBTYWx0ZWRfX33VbuENaACoq
 ixEJYz6MSuVvucl4GefOzsCosucvsoEYNTBdQau7wUKNYOpYHnoNLbcco7dQYcrdmjidK6ERqIn
 UX9EHkQBmdX79Nufdgcy/lt2rcvbF/0=
X-Authority-Analysis: v=2.4 cv=KuPYSmWN c=1 sm=1 tr=0 ts=6ad63edc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=6zmBB6n6n2PSzIUxsucA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2MyBTYWx0ZWRfX43BoobXgR+0T
 KZCJLpxL138OnyW5x/iwIrpr6r3HMJNH4YaBGVKhUmZd1agDrV7XvnT6WuVZqE4wNQtVFAgg4Qb
 WGPNKmro3468SZqees8VkQ/wiD2JdHLPYIQiUWH7mq48xkNBQfyiTSEUAGlXKsAdQk46Lc36SBm
 zgc6DBy2dj3dYSPBLsbBnFDxXbo2OpU972NTVaExErLkoR8efuNYDRxd5VRtDXSgj+UwthGmdKx
 9wx2WI0zbo2dZ6dbx3Vuo5//IPas3pHKiYsBNEFKfk3aXP6wGI3UbpiI0XeVfYEb5qH5TQy9QNQ
 jLFzO6aUSQ8LNLDq89fYSeCkI4I6KIEf+p6by0fQDwXMll3+ZkR0gx0i4JCAGXWfyI2/udHVAFt
 Cg+qQN8DbOZWO8r3kXxIyTkjEDMlVhqsC7kPbOMF9r8h+mphCB5wr67TBtYHjssNbotCluldEii
 98Q9YGxRpJuhuJ4NSYQ==
X-Proofpoint-ORIG-GUID: Z126wQ3t1oiPZ4iZaMFbBGY-H_0rt3Sy
X-Proofpoint-GUID: Z126wQ3t1oiPZ4iZaMFbBGY-H_0rt3Sy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190063
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/18/2026 4:03 PM, Philippe Mathieu-Daudé wrote:
> 'query-kvm' was deprecated in commit 824141dcf48, merged after
> the v11.1.0 release. Correct to prevent too early removal.
> 
> Fixes: 824141dcf48 ("hw/core: Deprecate query-kvm")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  docs/about/deprecated.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

